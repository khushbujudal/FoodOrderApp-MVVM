//
//  OrderHistoryViewModel.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 05/09/24.
//

import Foundation
import CoreData

class OrderHistoryViewModel : ObservableObject {
    private let viewContext: NSManagedObjectContext
    @Published var cartItems: [CartItem] = []

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchOrders() {
        guard let currentUser = UserManager.shared.currentUser else { return }
        
        if let orders = currentUser.orders {
            for cartItem in orders {
                cartItems.append(cartItem as! CartItem)
            }
        }
    }
}
