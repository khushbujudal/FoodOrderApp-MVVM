//
//  LoginView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 27/08/24.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: LoginViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: LoginViewModel(viewContext: DataManager.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Eat, Sleep, Repeat!!")
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
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Login")
                    }
                    .navigationDestination(isPresented: $viewModel.isLoginSuccessful, destination: {
                        Dashboard()
                    })
                    .customButtonStyle()
                    .padding()
                    
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: SignUpView().environment(\.managedObjectContext, viewContext)) {
                            Text("SignUp")
                                .foregroundColor(.purple)
                                .padding()
                                .underline()
                                .font(.title3)
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
            .padding()
         
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
}

#Preview {
    LoginView()
}
