//
//  AdInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

extension AdView {
    struct AdInfo: View {
        let advertisement: Advertisement
        @State var presentSheet: Bool = false
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    ForEach(advertisement.tags, id: \.self) { tag in
                        Tag(text: tag)
                    }
                }
                
                Text(advertisement.title)
                    .font(.title)
                    .padding(.top, 21)
                
                HStack(spacing: 27) {
                    if let weeklyWorkload = advertisement.weeklyWorkload {
                        Text("\(weeklyWorkload)h semanais")
                    }
                    
                    Text(advertisement.ongoing ? "Em andamento" : "Não iniciado")
                }
                .removePadding()
                .padding(.top, 7)
                
                Text(advertisement.description)
                    .removePadding()
                    .padding(.top, 10)
                
                // Images
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 177, height: 114)
                    }
                }
                
                Text("Vagas do Projeto")
                    .font(.title)
                
                VStack {
                    ForEach(advertisement.positions, id: \.self) { position in
                        Button {
                            presentSheet = true
                        } label: {
                            Position(position: position)
                                .sheet(isPresented: $presentSheet) {
                                    VStack(alignment: .leading) {
                                        Text(position.title)
                                            .font(.title)
                                        
                                        Text("\(position.vacancies - position.joined.count) vagas restantes")
                                        
                                        Text(position.description)
                                        
                                        Text("Pessoas ingressadas")
                                    }
                                    .padding(.horizontal, 16)
                                }
                        }

                    }
                }
            }
        }
    }

    private struct Tag: View {
        let text: String
        
        var body: some View {
            Text(text)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .padding(.horizontal, -5)
                        .padding(.vertical, -3)
                        .opacity(0.5)
                }
                .padding(.leading, 5)
                .padding(.top, 3)
        }
    }
    
    private struct Position: View {
        let position: Group.Position
        
        var body: some View {
            HStack(spacing: -20) {
                RoundedRectangleContent(cornerRadius: 5, fillColor: .red) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(.gray)
                            .frame(width: 39, height: 39)
                        
                        Text("\(position.joined.count)/\(position.vacancies)")
                    }
                }
                .frame(width: 95)
                .zIndex(1)
                
                RoundedRectangleContent(cornerRadius: 5, fillColor: .blue) {
                    Text(position.title)
                        .foregroundColor(.orange)
                }
                .frame(width: 269)
            }
            .frame(height: 60)
        }
    }
}

struct RoundedRectangleContent<Content: View>: View {
    let cornerRadius: CGFloat
    let fillColor: Color
    
    let content: () -> Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
            
            content()
        }
//        .fixedSize(horizontal: false, vertical: true)
    }
}
