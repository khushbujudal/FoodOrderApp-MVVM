//
//  CartItem+CoreDataProperties.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 03/09/24.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var cartID: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemImage: String?
    @NSManaged public var itemName: String?
    @NSManaged public var price: Double
    @NSManaged public var quanity: Int16
    @NSManaged public var user: User?

}

extension CartItem : Identifiable {

}
