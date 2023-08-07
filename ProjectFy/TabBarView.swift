//
//  TabBarView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            UserView(viewModel: viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserViewModel(user: User.mock[0])
        TabBarView(viewModel: viewModel)
            .environmentObject(UserViewModel(user: User.mock[0]))
    }
}
