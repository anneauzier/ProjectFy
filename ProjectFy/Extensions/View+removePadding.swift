//
//  View+removePadding.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

extension View {
    func removePadding() -> some View {
        self.padding(.top, -12)
    }
}
