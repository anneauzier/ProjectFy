//
//  NavigationRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 12/09/23.
//

import Foundation
import SwiftUI

indirect enum NavigationTransitionStyle {
    case push
    case presentModally
    case presentFullscreen
    case multiple(NavigationTransitionStyle)
}

protocol NavigationRouter {
    associatedtype Content: View
    
    var transition: NavigationTransitionStyle { get }
    
    @ViewBuilder
    func view() -> Content
}
