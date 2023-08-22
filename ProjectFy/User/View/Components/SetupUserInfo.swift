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
    @FocusState var isTextFieldFocused: Bool
    
    @Binding var user: User
    @Binding var canContinue: Bool
    @State private var height: CGFloat?

    let minHeight: CGFloat = 40
    let isNewUser: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormField(
                title: "Name",
                titleAccessibilityLabel: "Name",
                placeholder: "Your name...",
                text: $user.name,
                textFieldAccessibilityLabel: "Enter your name here"
            ).padding(.bottom, 40)
            
            if isNewUser {
                FormField(
                    title: "Username",
                    titleAccessibilityLabel: "Your username",
                    placeholder: "@",
                    text: $user.username,
                    textFieldAccessibilityLabel: "Type here your username"
                ).padding(.bottom, 40)
            }
            
            FormField(
                title: "Area of interest",
                titleAccessibilityLabel: "Area of interest",
                placeholder: "DUI/UX Design, iOS Developer, 3D Modelator...",
                text: $user.areaExpertise,
                textFieldAccessibilityLabel: "Enter your area of interest here (e.g. UI/UX)"
            ).padding(.bottom, 40)
            
            DropDownButton(
                title: "Level of knowledge in the area", textColor: .backgroundRole,
                selection: $user.expertise,
                menuItems: User.Expertise.allCases.map({ expertise in
                    MenuItem(name: expertise.rawValue, tag: expertise)
                })
            )
            .padding(.top, -15)
            .padding(.bottom, 40)
            
            FormField(
                title: "Your location",
                titleAccessibilityLabel: "Your location",
                placeholder: "Your location...",
                text: $user.region,
                textFieldAccessibilityLabel: "Enter your state and country"
            ).padding(.bottom, 40)

            CustomText(title: "Interests(opcional)",
                       text: $user.interestTags,
                       condition: user.interestTags.isEmpty,
                       placeholder: "Tag your interests, Ex: Design, Unity, iOS...")
            .padding(.bottom, 40)
            
            DropDownButton(
                title: "Availability",
                textColor: user.available ? .availableText : .unavailableText,
                selection: $user.available,
                menuItems: [
                    MenuItem(name: "Unavailable for projects", tag: false),
                    MenuItem(name: "Available for projects", tag: true)
                ]
            )
            .padding(.top, -15)
            .padding(.bottom, 40)
            
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

    private func textDidChange(_ textView: UITextView) {
        self.height = max(textView.contentSize.height, minHeight)
    }
}
