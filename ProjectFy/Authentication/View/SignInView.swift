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
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    @EnvironmentObject var groupViewModel: GroupViewModel
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    
    var isDeletingAccount = false
    @Binding var isNewUser: Bool?
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 182, height: 46)
                .padding(.bottom, 40)
            
            Spacer()

            if isDeletingAccount {
                VStack {
                    Text("To delete \(Text("your account").foregroundColor(.unavailableText)) you need to log into the app again...")
                        .font(Font.title2.bold())
                        .foregroundColor(.backgroundRole)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 68)
                    
                    Text("We're very sad to know that you want to delete your account on our app :(")
                        .foregroundColor(.editAdvertisementText)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 98)
                        .padding(.top, 5)
                }
                .padding(.top, -60)
                
            } else {
                Text("Find \(Text("people").foregroundColor(.textColorBlue)) to help you bring your \(Text("ideas").foregroundColor(.textColorBlue)) into the real world! :D")
                    .multilineTextAlignment(.center)
                    .font(Font.title.bold())
                    .foregroundColor(.signInColor)
                    .frame(width: UIScreen.main.bounds.width - 90)
                    .padding(.bottom, 40)
            }
            
            Spacer()
            
            Button {
                authenticationViewModel.authenticationService = SignInWithAppleService()
                
                authenticationViewModel.signIn { signInResult in
                    if isDeletingAccount {
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
            
            Text("Ao se cadastrar você concorda com os [Termos e Condições](https://www.deepl.com/translator) e com a [Política de Privacidade](https://www.deepl.com/translator) do aplicativo")
                .font(.body)
                .foregroundColor(.backgroundRole)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 40)
                .padding([.top, .bottom], 32)
        }
        .background(
            Image("grooupfundo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isNewUser: .constant(true))
    }
}
