//
//  Categories.swift
//  SwiftUITrainingProject
//
//  Created by Khushbu Judal on 29/08/24.
//

import Foundation

struct FoodItems : Codable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let idCategory, strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
    
    var id: String { idCategory ?? "" } // Conform to Identifiable by providing a unique ID
}
