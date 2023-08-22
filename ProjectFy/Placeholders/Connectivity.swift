//
//  Connectivity.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 22/08/23.
//

import SwiftUI

struct Connectivity: View {
    let image: Image
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center) {
            Circle()
                .frame(width: 155, height: 155)
                .foregroundColor(.backgroundTextBlue)
                .padding(.bottom, 20)
    
            Text(title)
                .font(Font.title2.bold())
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 104)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Text(description)
                .font(.body)
                .foregroundColor(.editAdvertisementText)
                .frame(width: UIScreen.main.bounds.width - 114)
                .multilineTextAlignment(.center)
        }.frame(height: UIScreen.main.bounds.height * 0.6)
    }
}

//"Looks like people haven't shared project ideas yet :("
//"You can start to share your project ideas by taping on \(Text("+").font(.title2).foregroundColor(.textColorBlue))"

//"Sorry, we couldn't load this page :("
//"Check your connection to see if there's something wrong"
