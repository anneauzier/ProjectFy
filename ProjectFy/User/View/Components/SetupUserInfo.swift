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
                title: "Name",
                titleAccessibilityLabel: "Name",
                placeholder: "Your name...",
                text: $user.name,
                textFieldAccessibilityLabel: "Enter your name here"
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
                title: "Area of interest",
                titleAccessibilityLabel: "Area of interest",
                placeholder: "DUI/UX Design, iOS Developer, 3D Modelator...",
                text: $user.areaExpertise,
                textFieldAccessibilityLabel: "Enter your area of interest here (e.g. UI/UX)"
            )
            
            DropDownButton(
                title: "Level of knowledge in the area",
                selection: $user.expertise,
                menuItems: User.Expertise.allCases.map({ expertise in
                    MenuItem(name: expertise.rawValue, tag: expertise)
                })
            )
            
            FormField(
                title: "Your location",
                titleAccessibilityLabel: "Your location",
                placeholder: "Your location...",
                text: $user.region,
                textFieldAccessibilityLabel: "Enter your state and country"
            )
            
            FormField(
                title: "Interests (optional)",
                titleAccessibilityLabel: "your interests",
                placeholder: "Tag your interests, Ex: Design, Unity, iOS...",
                text: $user.interestTags,
                textFieldAccessibilityLabel: "Enter your interests"
            )
            
            if !isNewUser {
                Toggle(isOn: $user.available) {
                    Text("Availability")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width - 40)
        
        .onAppear {
            checkIfCanContinue()
        }
        
        .onChange(of: user) { _ in
            checkIfCanContinue()
        }
        .padding(.top, 16)
    }
    
    private func checkIfCanContinue() {
        let isUserInfoFilled = userViewModel.isUserInfoFilled(user)
        
        if canContinue != isUserInfoFilled {
            canContinue = isUserInfoFilled
        }
    }
}
