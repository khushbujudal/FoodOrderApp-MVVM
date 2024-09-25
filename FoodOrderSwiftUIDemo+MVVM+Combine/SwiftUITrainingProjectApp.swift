//
//  SwiftUITrainingProjectApp.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 27/08/24.
//

import SwiftUI

@main
struct SwiftUITrainingProjectApp: App {
    
    @StateObject private var manger: DataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            
            LoginView()
                .environmentObject(manger)
                .environment(\.managedObjectContext, manger.container.viewContext)
        }
    }
}
