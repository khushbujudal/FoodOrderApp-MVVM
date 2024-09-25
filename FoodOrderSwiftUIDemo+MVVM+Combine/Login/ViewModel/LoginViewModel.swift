//
//  LoginViewModel.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 27/08/24.
//

import Foundation
import CoreData

class LoginViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoginSuccessful: Bool = false
    @Published var emailError: String?
    @Published var passwordError: String?

    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let passwordMinLength = 6
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func validateEmail() {
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        emailError = predicate.evaluate(with: email) ? nil : "Invalid email address"
    }
    
    func validatePassword() {
        passwordError = password.count >= passwordMinLength ? nil : "Password must be at least \(passwordMinLength) characters long"
    }
    
    func login() {
        if emailError == nil && passwordError == nil {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "emailID == %@ AND password == %@", email, password)
            
            do {
                let users = try viewContext.fetch(fetchRequest)
                if let user = users.first {
                    isLoginSuccessful = true
                    UserManager.shared.logIn(user: user)
                } else {
                    emailError = "Invalid email or password"
                }
            } catch {
                print("Fetch error: \(error.localizedDescription)")
            }
        }
    }
}
