//
//  ProjectFyApp.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 26/07/23.
//

import SwiftUI

@main
struct ProjectFyApp: App {
    @StateObject var viewModel = EditUserViewModel()
    var body: some Scene {
        WindowGroup {
            UserView(viewModel: viewModel)
        }
    }
}
