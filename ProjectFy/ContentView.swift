//
//  ContentView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 26/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            AdvertisementView()
        }
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
