//
//  PhoneAuthSignInView.swift
//  PhoneAuth
//
//  Created by Erich Flock on 28.04.22.
//

import SwiftUI

struct PhoneAuthSignInView: View {
    
    @StateObject var viewModel = PhoneAuthSignInViewModel()
    @Binding var isShowingSignIn: Bool
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Form {
                Section(content: {
                    TextField("", text: $viewModel.phoneNumber)
                        .placeholder(when: viewModel.phoneNumber.isEmpty, placeholder: {
                            Text("Phone Number")
                                .foregroundColor(Color(UIColor.black.withAlphaComponent(0.5)))
                        })
                        .foregroundColor(.black)
                        .keyboardType(.phonePad)
                    Button {
                        viewModel.verifyPhoneNumber(viewModel.phoneNumber)
                    } label: {
                        Text("Send Verification Code")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .controlSize(.regular)
                }, header: {
                    Text("Verification Code")
                        .foregroundColor(.black)
                })
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Section(content: {
                    TextField("", text: $viewModel.verificationCode)
                        .placeholder(when: viewModel.verificationCode.isEmpty, placeholder: {
                            Text("Code")
                                .foregroundColor(Color(UIColor.black.withAlphaComponent(0.5)))
                        })
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)
                    Button {
                        viewModel.signIn()
                        
                        if viewModel.userIsSignedIn() {
                            isShowingSignIn = false
                        }
                    } label: {
                        Text("Sign In")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .controlSize(.regular)
                }, header: {
                    Text("Sign In")
                        .foregroundColor(.black)
                })
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .listStyle(.grouped)
        }
        .frame(width: 300, height: 320)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 40)
        .overlay(XRoundedDismissButton(isShowingView: $isShowingSignIn), alignment: .topTrailing)
    }
}

struct PhoneAuthSignInView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthSignInView(isShowingSignIn: .constant(false))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
