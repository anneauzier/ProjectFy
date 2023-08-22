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
                    } label: {
                        HStack {
                            Text(item.name)
                                .font(.body)
                            if item.tag == selection {
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
                    .foregroundColor(.rectangleLine)
                    .padding(.top, 30)
            )
            
            .onAppear {
                if let item = menuItems.first(where: { $0.tag == selection }) {
                    text = item.name
                }
            }
        }
    }
}

struct MenuItem<T: Hashable>: Identifiable {
    let id = UUID()
    let name: String
    let tag: T
}

//            .padding(.horizontal, 10)
//            .frame(minWidth: 0, maxWidth: .infinity)
//            .overlay {
//                RoundedRectangle(cornerRadius: 8)
//                    .padding()
//                    .foregroundColor(.clear)
//                    .border(Color.secondary.opacity(0.18))
//            }
