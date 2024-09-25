//
//  DataBase.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 28/08/24.
//

import Foundation
import CoreData

class DataManager: NSObject, ObservableObject {
    
    @Published var users: [User] = [User]()

    static let shared = DataManager()

    let container: NSPersistentContainer = NSPersistentContainer(name: "SwiftUITrainingProject")
    
    override init() {
        super.init()
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }        }
    }
}
