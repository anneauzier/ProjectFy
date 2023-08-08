//
//  TabBarView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            AdvertisementsView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            UserView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
