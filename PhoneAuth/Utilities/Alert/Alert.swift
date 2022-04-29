//
//  Alert.swift
//  PhoneAuth
//
//  Created by Erich Flock on 29.04.22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let phoneNumberEmpty = AlertItem(title: Text("Error"),
                                       message: Text("Phone number cannot be empty."),
                                       dismissButton: .default(Text("OK")))
    
    static let verificationIdEmpty = AlertItem(title: Text("Error"),
                                               message: Text("Verification ID empty. Please try it again"),
                                               dismissButton: .default(Text("OK")))
    
    static let verificationCodeEmpty = AlertItem(title: Text("Error"),
                                               message: Text("Verification Code empty. Please enter the code we sent to you."),
                                               dismissButton: .default(Text("OK")))
    
    static let noUserUID = AlertItem(title: Text("Error"),
                                               message: Text("Server returned no user UID. Please try it again."),
                                               dismissButton: .default(Text("OK")))
    
    static let userSignInSuccess = AlertItem(title: Text("Success"),
                                               message: Text("User signed in successfully."),
                                               dismissButton: .default(Text("OK")))
    
    static func createAlertWith(message: String) -> AlertItem {
        AlertItem(title: Text("Error"),
                  message: Text(message),
                  dismissButton: .default(Text("OK")))
    }
}
