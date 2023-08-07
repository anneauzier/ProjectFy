//
//  ContentView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 26/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var advertisementViewModel = AdvertisementView.ViewModel(service: AdvertisementMockupService())
    
    var body: some View {
        NavigationView {
            AdvertisementView()
                .environmentObject(advertisementViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
