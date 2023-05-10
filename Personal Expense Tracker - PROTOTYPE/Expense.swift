//
//  Expense.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import Foundation

class Expense: Codable {
    let id: Int
    let name: String
    let amount: Double
    let date: Date

    init(id: Int, name: String, amount: Double, date: Date) {
        self.id = id
        self.name = name
        self.amount = amount
        self.date = date
    }
}
