//
//  UIApplication.swift
//  IOSTask
//
//  Created by Farido on 13/09/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
