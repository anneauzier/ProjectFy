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
    @Binding var selection: T
    let menuItems: [MenuItem<T>]
    
    @State var text: String = ""
    
    var body: some View {
        Group {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            
            Menu {
                ForEach(menuItems) { item in
                    Button {
                        text = item.name
                        selection = item.tag
                    } label: {
                        HStack {
                            Text(item.name)
                            
                            if item.name == String(describing: selection) {
                                Spacer()
                                
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                            }
                        }
                    }

                }
            } label: {
                Text(text)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "arrowtriangle.down.fill")
                    .foregroundColor(Color.black)
            }
            
            .onAppear {
                if let item = menuItems.first {
                    text = item.name
                }
            }
            
            .padding(.horizontal, 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .padding()
                    .foregroundColor(.clear)
                    .border(Color.secondary.opacity(0.18))
            }
        }
    }
}

struct MenuItem<T: Hashable>: Identifiable {
    let id = UUID()
    let name: String
    let tag: T
}

