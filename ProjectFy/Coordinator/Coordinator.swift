//
//  Coordinator.swift
//  ProjectFy
//
//  Created by Iago Ramos on 12/09/23.
//

import Foundation
import SwiftUI

class Coordinator<Router: NavigationRouter>: ObservableObject {
    let navigationController: UINavigationController
    private let root: Router
    
    private var environmentObjects: [any ObservableObject] = []
    private var modalNavigationController: UINavigationController?
    
    init(navigationController: UINavigationController = .init(), root: Router) {
        self.navigationController = navigationController
        self.root = root
    }
    
    func start(environmentObjects: [any ObservableObject] = []) {
        self.environmentObjects = environmentObjects
        show(root)
    }
    
    private func setEnviromentObjects(on view: any View) -> any View {
        var view = view.environmentObject(self)
        view = environmentObjects.reduce(view, { $0.environmentObject($1) })
        
        return view
    }
    
    func show(_ route: Router, animated: Bool = true) {
        let view = setEnviromentObjects(on: route.view())
        let viewController = UIHostingController(rootView: AnyView(view))
        
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
            
        case .presentModally:
            navigationController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
            
        case .presentFullscreen:
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
            
        case .multiple(let transition):
            switch transition {
            case .push:
                guard let controller = modalNavigationController else { return }
                controller.pushViewController(viewController, animated: animated)
                
            case .presentModally:
                modalNavigationController = ModalNavigationController(
                    rootViewController: viewController,
                    onDismiss: { [weak self] in
                        self?.modalNavigationController = nil
                    }
                )
                
                if let controller = modalNavigationController {
                    navigationController.present(controller, animated: animated)
                }
                
            default:
                return
            }
        }
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    private class ModalNavigationController: UINavigationController {
        let onDismiss: () -> Void
        
        init(rootViewController: UIViewController, onDismiss: @escaping () -> Void) {
            self.onDismiss = onDismiss
            super.init(rootViewController: rootViewController)
            
            self.modalPresentationStyle = .formSheet
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            if isBeingDismissed {
                onDismiss()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
