//
//  SignUpViewModel.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 01/09/24.
//

import Foundation
import CoreData

class SignUpViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUpSuccessful : Bool = false
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
    
    func signUP() {
        if emailError == nil && passwordError == nil {
            if !isExistingUser() {
                createUser()
            } else {
                emailError = "User Already Exists!!, please login to your account!"
            }
        }
    }
    
    func createUser() {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.emailID = email
        newUser.password = password
        
        do {
            try viewContext.save()
            isSignUpSuccessful = true
            UserManager.shared.logIn(user: newUser)
        } catch {
            isSignUpSuccessful = false
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func isExistingUser() -> Bool{
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "emailID == %@ AND password == %@", email, password)
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            if users.first != nil {
                return true
            } else {
                return false
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
            return false
        }
    }
}
