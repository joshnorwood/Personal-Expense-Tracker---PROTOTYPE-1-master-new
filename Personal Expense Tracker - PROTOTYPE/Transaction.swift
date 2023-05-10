//
//  Transaction.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation

class Transaction {
    var transactionID: Int
    var type: String
    var amount: Double
    var description: String
    var date: Date
    var category: Category
    
    init(transactionID: Int, type: String, amount: Double, description: String, date: Date, category: Category) {
        self.transactionID = transactionID
        self.type = type
        self.amount = amount
        self.description = description
        self.date = date
        self.category = category
    }
}
