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
        @EnvironmentObject var userViewModel: UserViewModel
        
        let advertisement: Advertisement
        
        @Binding var presentSheet: Bool
        @Binding var selectedPosition: ProjectGroup.Position?
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(advertisement.tags.split(separator: ","), id: \.self) { tag in
                            Tag(text: String(tag))
                        }
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
                            selectedPosition = position
                            Haptics.shared.selection()
                        } label: {
                            Position(position: position)
                        }
                        
                        .onChange(of: selectedPosition, perform: { selectedPosition in
                            if selectedPosition != nil {
                                presentSheet = true
                            }
                        })
                        
                        .onChange(of: presentSheet) { presentSheet in
                            if !presentSheet {
                                selectedPosition = nil
                            }
                        }
                        
                        .sheet(isPresented: $presentSheet) {
                            if let position = selectedPosition {
                                PositionDetails(advertisement: advertisement, position: position)
                            } else {
                                Text("Posição não encontrada!")
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
            RoundedRectangleContent(cornerRadius: 5, fillColor: .gray) {
                Text(text)
                    .foregroundColor(.white)
                    .padding(.all, 5)
            }
        }
    }
    
    private struct Position: View {
        let position: ProjectGroup.Position
        
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
    
    private struct PositionDetails: View {
        @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
        @EnvironmentObject var userViewModel: UserViewModel
        
        let advertisement: Advertisement
        let position: ProjectGroup.Position
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(position.title)
                    .font(.title)
                
                Text("\(position.vacancies - position.joined.count) vagas restantes")
                    .foregroundColor(.gray)
                    .removePadding()
                
                Text(position.description)
                    .padding(.top, -5)
                
                Text("Pessoas ingressadas")
                    .font(.title)
                    .removePadding()
                    .padding(.top, 37)
                
                Spacer()
                
//                let applicationIDs = advertisement.applicationsIDs
//                let userID = userViewModel.users[0].id
//
//                let hasApplied = applicationIDs.keys.contains(userID)
//                let hasAppliedForThisPosition = hasApplied && applicationIDs[userID]?.id == position.id
//                
//                let buttonText = hasAppliedForThisPosition ? "Retirar solicitação" : "Solicitar ingresso"
//                let isDisabled = hasApplied && !hasAppliedForThisPosition
                
//                Button {
//                    if !hasApplied {
//                        advertisementsViewModel.apply(userID: userID, for: position)
//                        userViewModel.apply(to: position.id)
//
//                        Haptics.shared.notification(.success)
//                        return
//                    }
//
//                    advertisementsViewModel.unapply(userID: userID, from: position)
//                    userViewModel.unapply(from: position.id)
//
//                    Haptics.shared.notification(.success)
//                } label: {
//                    RoundedRectangleContent(cornerRadius: 5, fillColor: .gray) {
//                        Text(buttonText)
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                    }
//                    .frame(maxHeight: 60)
//                    .padding(.top, 20)
//                }
//                .disabled(isDisabled)
//
//                .simultaneousGesture(TapGesture().onEnded({ _ in
//                    if isDisabled {
//                        Haptics.shared.notification(.error)
//                    }
//                }))
            }
            
            .foregroundColor(.black)
            .padding(.horizontal, 25)
            .padding(.top, 30)
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
