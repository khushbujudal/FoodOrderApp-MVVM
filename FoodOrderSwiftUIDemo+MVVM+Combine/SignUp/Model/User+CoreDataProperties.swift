//
//  User+CoreDataProperties.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 04/09/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var emailID: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var cartItems: NSSet?
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for cartItems
extension User {

    @objc(addCartItemsObject:)
    @NSManaged public func addToCartItems(_ value: CartItem)

    @objc(removeCartItemsObject:)
    @NSManaged public func removeFromCartItems(_ value: CartItem)

    @objc(addCartItems:)
    @NSManaged public func addToCartItems(_ values: NSSet)

    @objc(removeCartItems:)
    @NSManaged public func removeFromCartItems(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension User {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: CartItem)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: CartItem)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

extension User : Identifiable {

}
