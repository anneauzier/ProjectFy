//
//  DetailsGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 09/08/23.
//

import SwiftUI

struct DetailsGroupView: View {
    @State var teste: String = ""

    var body: some View {
        VStack {
            Image("Group4")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("Group's name")
            TextField("Enter your name", text: $teste)
                .padding(.bottom, 20)
            
            Text("Description")
            
            ZStack {
                if teste.isEmpty {
                    Text("Placeholder Text")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                
                TextEditor(text: $teste)
                    
            }
        }.padding(.horizontal)
    }
}

struct DetailsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsGroupView(teste: "nj,nkj")
    }
}
