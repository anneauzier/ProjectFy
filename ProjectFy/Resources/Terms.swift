//
//  Terms.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 22/08/23.
//

import SwiftUI

struct Terms: View {

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Terms and \nconditions of use")
                        .font(Font.largeTitle.bold())
                        .padding(.top, 32)
                    Group {
                        Text(
                """
                Grooup! App Terms and Conditions of Use
                By using the App, you agree to the following terms and conditions of use ("Terms").
                It is important that you read the Terms carefully before using the App.
                If you do not agree to these Terms, we ask that you do not continue to use the App.
                """
                        )
                        Text(
                """
                1. Acceptance of the Terms: By accessing or using the Application, you acknowledge      that you have read, understood and agree to be bound by these Terms.
                """
                        )
                        Text(
                """
                2. Responsible Use and Sharing of Ideas:
                The Application allows users to share ideas, opinions and information.
                """
                        )
                        Text(
                """
                However, you understand and agree that the Application is not responsible for the consequences of sharing ideas, opinions or information through the Application. You are solely responsible for the content you share and the consequences of your actions.
                """
                        )
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct Terms_Previews: PreviewProvider {
    static var previews: some View {
        Terms()
    }
}
