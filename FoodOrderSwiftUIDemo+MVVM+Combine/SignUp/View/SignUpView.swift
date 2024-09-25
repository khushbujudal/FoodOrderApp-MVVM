//
//  SignUpView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 01/09/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: SignUpViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: SignUpViewModel(viewContext: DataManager.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Create Account!!")
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing))
                    .font(.largeTitle)
                    .padding(.top, 100)
                
                VStack {
                    TextField("User Email", text: $viewModel.email)
                        .customTextFieldStyle()
                        .onChange(of: viewModel.email) { _, _ in
                            viewModel.validateEmail()
                        }
                    
                    if let emailError = viewModel.emailError {
                        Text(emailError)
                            .errorTextStyle()
                    }
                    
                    SecureField("Password", text: $viewModel.password)
                        .customTextFieldStyle()
                        .onChange(of: viewModel.password) { _, _ in
                            viewModel.validatePassword()
                        }
                    
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .errorTextStyle()
                    }
                    
                    NavigationLink(destination: Dashboard()) {
                        Button {
                            viewModel.signUP()
                        } label: {
                            Text("Sign Up")
                        } .customButtonStyle()
                        .padding()
                    }
                }
                
                HStack {
                    Spacer()
                    NavigationLink(destination: LoginView().environment(\.managedObjectContext, viewContext)) {
                        Text("Login")
                            .foregroundColor(.purple)
                            .padding()
                            .underline()
                            .font(.title3)
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SignUpView()
}

