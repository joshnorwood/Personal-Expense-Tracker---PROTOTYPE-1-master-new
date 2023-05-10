//
//  Analytics.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation

class Analytics {
    var userID: Int
    var incomeByCategory: [Category: Double]
    var expensesByCategory: [Category: Double]
    
    init(userID: Int, incomeByCategory: [Category: Double], expensesByCategory: [Category: Double]) {
        self.userID = userID
        self.incomeByCategory = incomeByCategory
        self.expensesByCategory = expensesByCategory
    }
    
    func updateIncomeByCategory() {
        // Update income by category based on transactions
    }
    
    func updateExpensesByCategory() {
        // Update expenses by category based on transactions
    }
}

