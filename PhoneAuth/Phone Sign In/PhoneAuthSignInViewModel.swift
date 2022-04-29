//
//  PhoneAuthSignInViewModel.swift
//  PhoneAuth
//
//  Created by Erich Flock on 28.04.22.
//

import SwiftUI
import Firebase

final class PhoneAuthSignInViewModel: ObservableObject {
    
    @Published var phoneNumber = ""
    @Published var alertItem: AlertItem?
    @Published var verificationID: String?
    @Published var verificationCode = ""
    
    func verifyPhoneNumber(_ phone: String) {
        guard !phone.isEmpty else {
            alertItem = AlertContext.phoneNumberEmpty
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { [weak self] verificationID, error in
            guard let self = self else { return }
            
            if let error = error {
                self.alertItem = AlertContext.createAlertWith(message: error.localizedDescription)
                return
            }
            
            guard let verificationID = verificationID, !verificationID.isEmpty else {
                self.alertItem = AlertContext.verificationIdEmpty
                return
            }
            
            self.verificationID = verificationID
        }
    }
    
    func signIn() {
        guard let verificationID = verificationID else {
            alertItem = AlertContext.verificationIdEmpty
            return
        }
        
        guard !verificationCode.isEmpty else {
            alertItem = AlertContext.verificationCodeEmpty
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.alertItem = AlertContext.createAlertWith(message: error.localizedDescription)
                return
            }
            
            guard let uid = authResult?.user.uid, !uid.isEmpty else {
                self.alertItem = AlertContext.noUserUID
                return
            }
            
            self.objectWillChange.send()
            
            return
        }
    }
    
    func userIsSignedIn() -> Bool {
        Auth.auth().currentUser != nil
    }
    
}
