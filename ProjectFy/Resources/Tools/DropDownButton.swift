//
//  DropDownButton.swift
//  ProjectFy
//
//  Created by Iago Ramos on 08/08/23.
//

import Foundation
import SwiftUI

struct DropDownButton<T: Hashable>: View {
    let title: String
    let textColor: Color
    @Binding var selection: T
    let menuItems: [MenuItem<T>]
    
    @State var text: String = ""
    
    var body: some View {
        Group {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Menu {
                ForEach(menuItems) { item in
                    Button {
                        text = item.name
                        selection = item.tag
                        print(item.name)
                        print(item.tag)
                    } label: {
                        HStack {
                            Text(item.name)
                                .font(.body)
                            if item.name == String(describing: selection).capitalized {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            } label: {
                Text(text)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.black)
            }.background(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.2))
                    .padding(.top, 28)
            )
            
            .onAppear {
                if let item = menuItems.first {
                    text = item.name
                }
            }

//            .padding(.horizontal, 10)
//            .frame(minWidth: 0, maxWidth: .infinity)
//            .overlay {
//                RoundedRectangle(cornerRadius: 8)
//                    .padding()
//                    .foregroundColor(.clear)
//                    .border(Color.secondary.opacity(0.18))
//            }
        }
    }
}

struct MenuItem<T: Hashable>: Identifiable {
    let id = UUID()
    let name: String
    let tag: T
}
