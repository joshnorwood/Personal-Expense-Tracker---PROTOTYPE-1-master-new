//
//  ExpenseCategory.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import Foundation

struct ExpenseCategory: Codable {
    let id: Int
    let name: String
    let budgetAmount: Double
    var currentSpent: Double = 0.0
    
    init(id: Int, name: String, budgetAmount: Double, currentSpent: Double = 0.0) {
        self.id = id
        self.name = name
        self.budgetAmount = budgetAmount
        self.currentSpent = currentSpent
    }
}
