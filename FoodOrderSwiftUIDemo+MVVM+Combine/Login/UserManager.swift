//
//  UserManager.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 02/09/24.
//

import Foundation

class UserManager: ObservableObject {
    var currentUser: User?
    static let shared = UserManager()

    private init() {
    }
    
    func logIn(user : User) {
        self.currentUser = user
    }
    
    func logOut() {
        self.currentUser = nil
    }
}
