//
//  Category.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation

class Category: Hashable {
    var categoryID: Int
    var name: String
    var userID: Int
    
    init(categoryID: Int, name: String, userID: Int) {
        self.categoryID = categoryID
        self.name = name
        self.userID = userID
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.categoryID == rhs.categoryID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryID)
    }
}


