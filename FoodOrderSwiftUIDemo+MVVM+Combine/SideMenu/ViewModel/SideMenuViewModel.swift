//
//  SideMenuViewModel.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 05/09/24.
//

import Foundation
import CoreData

class SideMenuViewModel : ObservableObject {
    private let viewContext: NSManagedObjectContext
    private var cartItems: [CartItem] = []
    @Published var isLoggedOut : Bool = false
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchCartItems() {
        guard let currentUser = UserManager.shared.currentUser else { return }
        
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@", currentUser)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cartID", ascending: true)]
        
        do {
            cartItems = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch cart items: \(error.localizedDescription)")
        }
    }

    
    func logout() {
        fetchCartItems()
        
        guard let currentUser = UserManager.shared.currentUser else { return }
        
        for cartItem in cartItems {
            currentUser.removeFromCartItems(cartItem)
        }
        isLoggedOut = true
    }
}
