//
//  Budget.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation

class Budget {
    var budgetID: Int
    var amount: Double
    var startDate: Date
    var endDate: Date
    var category: Category
    
    init(budgetID: Int, amount: Double, startDate: Date, endDate: Date, category: Category) {
        self.budgetID = budgetID
        self.amount = amount
        self.startDate = startDate
        self.endDate = endDate
        self.category = category
    }
}

