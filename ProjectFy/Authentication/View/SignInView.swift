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
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    @EnvironmentObject var groupViewModel: GroupViewModel
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel

    @Binding var isNewUser: Bool?
    var isDeletingAccount = false
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 182, height: 46)
                .padding(.top, 10)
            
            Spacer()

            if isDeletingAccount {
                VStack {
                    Text("We're very sad to know that you want to \("delete".colored(with: .unavailableText)) your account on the app :(")
                        .font(Font.title.bold())
                        .foregroundColor(.backgroundRole)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 68)
                    
                    Text("To \("delete your account".colored(with: .unavailableText)) you need to log into the app again...")
                        .foregroundColor(.editAdvertisementText)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 98)
                        .padding(.top, 20)
                }
            } else {
                Text("Find \("people".colored(with: .textColorBlue)) to help you bring your \("ideas".colored(with: .textColorBlue)) into the real world! :D")
                    .multilineTextAlignment(.center)
                    .font(Font.title.bold())
                    .foregroundColor(.signInColor)
                    .frame(width: UIScreen.main.bounds.width - 90)
                    .padding(.top, 40)
            }
            
            Spacer()
            
            Button {
                authenticationViewModel.authenticationService = SignInWithAppleService()
                
                authenticationViewModel.signIn { signInResult in
                    if isDeletingAccount {
                        dismiss()
                        deleteAllUserData(with: signInResult.identityToken)
                        
                        return
                    }
                    
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
                    type: .continue,
                    style: colorScheme == .light ? .black : .white
                )
            }.frame(width: UIScreen.main.bounds.width - 40, height: 56)
                .padding(.top, 40)

            if !isDeletingAccount {
                Text("By registering you agree to the [Terms and \nConditions](https://encurtador.com.br/rBMW8) and [Privacy Policy](https://encurtador.com.br/otJO6) of the app.")
                    .font(.body)
                    .foregroundColor(.backgroundRole)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .padding(.top, 20)
            }
        }
        .background(
            Image("groupBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
                .opacity(isDeletingAccount ? 0 : 1)
        )
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
    
    private func deleteAllUserData(with userID: String) {
        MessagingService.shared.deleteTokens()
        advertisementsViewModel.deleteAllAdvertisements(from: userID)
        groupViewModel.exitOfAllGroups()
        notificationsViewModel.deleteAllNotifications()
        
        userViewModel.deleteUser()
        authenticationViewModel.delete()
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView(isNewUser: .constant(true))
//    }
//}
