//
//  CustomAlert.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/08/23.
//

import SwiftUI

struct CustomAlert: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .foregroundColor(.white)

            Spacer()
            
//            Button {
//                print("APERTEEEEEIII")
//            } label: {
//                Text("Undo")
//                    .font(Font.headline)
//                    .foregroundColor(.white)
//            }

        }.frame(width: UIScreen.main.bounds.width - 80)
         .padding()
         .background(Color.black.opacity(0.8))
         .cornerRadius(12)
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(text: "notification")
    }
}
