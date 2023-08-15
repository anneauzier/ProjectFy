//
//  SetupUserInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 14/08/23.
//

import Foundation
import SwiftUI

struct SetupUserInfo: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var user: User
    @Binding var canContinue: Bool
    let isNewUser: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormField(
                title: "Nome",
                titleAccessibilityLabel: "Seu nome",
                placeholder: "Digite aqui seu nome",
                text: $user.name,
                textFieldAccessibilityLabel: "Digite aqui seu nome"
            )
            
            if isNewUser {
                FormField(
                    title: "Username",
                    titleAccessibilityLabel: "Your username",
                    placeholder: "@",
                    text: $user.username,
                    textFieldAccessibilityLabel: "Type here your username"
                )
            }
            
            FormField(
                title: "Área de conhecimento",
                titleAccessibilityLabel: "Digite aqui sua área de interesse (Ex: UI/UX)",
                placeholder: "Digite aqui sua área de interesse (Ex: UI/UX)",
                text: $user.areaExpertise,
                textFieldAccessibilityLabel: "Digite aqui sua área de interesse"
            )
            
            DropDownButton(
                title: "Nível de conhecimento",
                selection: $user.expertise,
                menuItems: User.Expertise.allCases.map({ expertise in
                    MenuItem(name: expertise.rawValue, tag: expertise)
                })
            )
            
            FormField(
                title: "Localização",
                titleAccessibilityLabel: "Sua localização",
                placeholder: "State, Country",
                text: $user.region,
                textFieldAccessibilityLabel: "Digite seu estado e país"
            )
            
            FormField(
                title: "Interesses",
                titleAccessibilityLabel: "Seus interesses",
                placeholder: "Seus interesses",
                text: $user.interestTags,
                textFieldAccessibilityLabel: "Digite seus interesses"
            )
            
            if !isNewUser {
                Toggle(isOn: $user.available) {
                    Text("Disponibilidade")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
        }
        
        .onAppear {
            checkIfCanContinue()
        }
        
        .onChange(of: user) { _ in
            checkIfCanContinue()
        }
        
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private func checkIfCanContinue() {
        let isUserInfoFilled = userViewModel.isUserInfoFilled(user)
        
        if canContinue != isUserInfoFilled {
            canContinue = isUserInfoFilled
        }
    }
}
