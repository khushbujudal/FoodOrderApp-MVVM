//
//  ContentView.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 27/08/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var isValidLogin = false
    @State var isValidPassword = false
    
    var body: some View {
        NavigationView {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
