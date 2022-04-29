//
//  PhoneAuthViewModel.swift
//  PhoneAuth
//
//  Created by Erich Flock on 29.04.22.
//

import SwiftUI
import Firebase

class PhoneAuthViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    
    func isUserSignedIn() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func getUserPhone() -> String? {
        Auth.auth().currentUser?.phoneNumber
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.objectWillChange.send()
        } catch {
            alertItem = AlertContext.createAlertWith(message: "Sign out error: \(error.localizedDescription)")
        }
    }
    
}
