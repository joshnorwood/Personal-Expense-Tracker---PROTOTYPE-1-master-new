//
//  Expense.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import Foundation

class Expense: Codable {
    let id: Int
    let categoryId: Int
    let name: String
    let amount: Double
    let date: Date

    init(id: Int, categoryId: Int, name: String, amount: Double, date: Date) {
        self.id = id
        self.categoryId = categoryId
        self.name = name
        self.amount = amount
        self.date = date
    }
}

