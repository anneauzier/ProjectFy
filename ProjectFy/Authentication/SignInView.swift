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
    
    var body: some View {
        VStack {
            Text("Encontre pessoas para realizar projetos paralelos com você!")
                .multilineTextAlignment(.center)
                .font(.title)
            
            Divider()
            
            Button {
                viewModel.authenticationService = SignInWithAppleService()
                
                viewModel.signIn { signInResult in
                    if userViewModel.getUser(with: signInResult.identityToken) != nil {
                        return
                    }
                    
                    let user = User(signInResult: signInResult)
                    
                    userViewModel.createUser(user)
                    userViewModel.setUser(with: user.id)
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(
                    type: .default,
                    style: colorScheme == .light ? .black : .white
                )
            }
            .frame(width: 375, height: 55)

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
        SignInView()
    }
}
