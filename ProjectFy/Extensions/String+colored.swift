//
//  String+colored.swift
//  ProjectFy
//
//  Created by Iago Ramos on 23/08/23.
//

import Foundation
import SwiftUI

extension String {
    func colored(with color: Color) -> Text {
        return Text(self).foregroundColor(color)
    }
}
