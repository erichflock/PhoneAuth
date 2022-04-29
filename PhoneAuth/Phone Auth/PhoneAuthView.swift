//
//  ContentView.swift
//  PhoneAuth
//
//  Created by Erich Flock on 28.04.22.
//

import SwiftUI

struct PhoneAuthView: View {
    
    @StateObject var viewModel = PhoneAuthViewModel()
    @State var isShowingSignIn = false
    
    var body: some View {
        ZStack {
            if viewModel.isUserSignedIn() {
                VStack {
                    Text("Welcome!\nYou are logged in with phone number \n\(viewModel.getUserPhone() ?? "")")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    SignOutButton(phoneAuthViewModel: viewModel)
                }
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
            } else {
                SignInButton(isShowingSignIn: $isShowingSignIn)
            }
            
            if isShowingSignIn {
                PhoneAuthSignInView(isShowingSignIn: $isShowingSignIn)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthView()
    }
}

struct SignInButton: View {
    
    @Binding var isShowingSignIn: Bool
    
    var body: some View {
        Button {
            isShowingSignIn = !isShowingSignIn
        } label: {
            Text("Phone Number Sign In")
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .controlSize(.large)
    }
}

struct SignOutButton: View {
    
    @ObservedObject var phoneAuthViewModel: PhoneAuthViewModel
    
    var body: some View {
        Button {
            phoneAuthViewModel.signOut()
        } label: {
            Text("Sign Out")
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .controlSize(.large)
    }
}
