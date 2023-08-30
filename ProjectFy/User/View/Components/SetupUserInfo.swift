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
    @Environment(\.dynamicTypeSize) var sizeCategory
    @FocusState var isTextFieldFocused: Bool
    
    @Binding var user: User
    @Binding var canContinue: Bool
    @State private var height: CGFloat?
    
    let minHeight: CGFloat = 30
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
            
            FormField(
                title: "Area of interest",
                titleAccessibilityLabel: "Area of interest",
                placeholder: sizeCategory.isAccessibilitySize ? "Ex: UI/UX Design..." :
                    "Ex: UI/UX Design, iOS Developer, 3D Modelator..." ,
                text: $user.areaExpertise,
                textFieldAccessibilityLabel: "Enter your area of interest here (e.g. UI/UX)"
            ).padding(.top, 40)
            
            DropDownButton(
                title: "Level of knowledge in the area", textColor: .backgroundRole,
                selection: $user.expertise,
                menuItems: User.Expertise.allCases.map({ expertise in
                    MenuItem(name: expertise.rawValue, tag: expertise)
                })
            )
            .padding(.top, 40)
            
            FormField(
                title: "Your location",
                titleAccessibilityLabel: "Your location",
                placeholder: "Your location...",
                text: $user.region,
                textFieldAccessibilityLabel: "Enter your state and country"
            )
            .padding(.top, 40)
            
            CustomText(title: "Interests",
                       optional: true,
                       text: $user.interestTags,
                       condition: user.interestTags.isEmpty,
                       placeholder: sizeCategory.isAccessibilitySize ? "Ex: Design, Unity..." :
                        "Tag your interests, Ex: Design, Unity, iOS...")
            .padding(.top, 40)
            
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

//            if isNewUser {
//                FormField(
//                    title: "Username",
//                    titleAccessibilityLabel: "Your username",
//                    placeholder: "@",
//                    text: $user.username,
//                    textFieldAccessibilityLabel: "Type here your username"
//                )
//                .padding(.top, 40)
//            }

//            DropDownButton(
//                title: "Availability",
//                textColor: user.available ? .availableText : .unavailableText,
//                selection: $user.available,
//                menuItems: [
//                    MenuItem(name: "Unavailable for projects", tag: false),
//                    MenuItem(name: "Available for projects", tag: true)
//                ]
//            )
//            .padding(.top, 35)
