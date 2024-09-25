//
//  ItemDetailViewModel.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 02/09/24.
//

import Foundation
import CoreData

class ItemDetailViewModel: ObservableObject {
    
    @Published var cartItems: [CartItem] = []
    @Published var isItemAdded : Bool = false
    @Published var quantity : Int = 1
    @Published var orderPlaced : Bool = false
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
  
    func addToCard(cartItem : CartItem) {
        guard let currentUser = UserManager.shared.currentUser else {
            print("No User is logged In!")
            return
        }

        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cartID == %@ AND user == %@", cartItem.cartID ?? "", currentUser)
        
        do {
            let existingItems = try viewContext.fetch(fetchRequest)
            
            if let existingItem = existingItems.first {
                existingItem.quanity += Int16(quantity)
                existingItem.price = existingItem.price + (cartItem.price * Double(quantity))
            } else {
                let newCartItem = CartItem(context: viewContext)
                newCartItem.cartID = cartItem.cartID
                newCartItem.itemDescription = cartItem.itemDescription
                newCartItem.itemName = cartItem.itemName
                newCartItem.itemImage = cartItem.itemImage
                newCartItem.quanity = Int16(quantity)
                newCartItem.price = cartItem.price * Double(quantity)
                newCartItem.user = currentUser
                
                currentUser.addToCartItems(newCartItem)
            }
            try viewContext.save()
            isItemAdded = true
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
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
    
    func placeOrder() {
        guard let currentUser = UserManager.shared.currentUser else { return }
        
        for cartItem in cartItems {
            currentUser.addToOrders(cartItem)
            currentUser.removeFromCartItems(cartItem)
            orderPlaced = true
        }
    }
}
