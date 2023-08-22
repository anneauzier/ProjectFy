//
//  SignInView.swift
//  ProjectFy
//
//  Created by Iago Ramos on 10/08/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var isNewUser: Bool?
    
    var body: some View {
        VStack {
            
            Image("logo")
                .padding(.bottom, 34)

            Text("Find \(Text("people").foregroundColor(.textColorBlue)) to help you bring your \(Text("ideas").foregroundColor(.textColorBlue)) into the real world! :D")
                .frame(width: UIScreen.main.bounds.width - 105)
                .font(Font.title2.bold())
                .foregroundColor(.signInColor)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
            
            Button {
                viewModel.authenticationService = SignInWithAppleService()
                
                viewModel.signIn { signInResult in
                    if userViewModel.getUser(with: signInResult.identityToken) != nil {
                        return
                    }
                    
                    let user = User(signInResult: signInResult)
                    
                    userViewModel.createUser(user)
                    userViewModel.setUser(with: user.id)
                    
                    isNewUser = true
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(
                    type: .default,
                    style: colorScheme == .light ? .black : .white
                )
            }.frame(width: UIScreen.main.bounds.width - 40, height: 56)

        }
        .padding()
    }
    
    private struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
        let type: ASAuthorizationAppleIDButton.ButtonType
        let style: ASAuthorizationAppleIDButton.Style
        
        func makeUIView(context: Context) -> some UIView {
            return ASAuthorizationAppleIDButton(type: type, style: style)
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isNewUser: .constant(true))
    }
}
