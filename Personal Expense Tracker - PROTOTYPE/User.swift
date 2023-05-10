//
//  User.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation

class User: Codable {
    let userID: Int
    let email: String
    let password: String
    var occupation: String
    var salary: Double
    var expenses: [Expense]
    var expenseCategories: [ExpenseCategory]

    init(userID: Int, email: String, password: String, occupation: String, salary: Double, expenses: [Expense] = [], expenseCategories: [ExpenseCategory] = []) {
        self.userID = userID
        self.email = email
        self.password = password
        self.occupation = occupation
        self.salary = salary
        self.expenses = expenses
        self.expenseCategories = expenseCategories
    }
}

