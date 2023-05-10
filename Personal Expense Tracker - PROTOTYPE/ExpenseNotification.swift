//
//  Notification.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation

class ExpenseNotification {
    var notificationID: Int
    var message: String
    var sentDate: Date
    var userID: Int
    
    init(notificationID: Int, message: String, sentDate: Date, userID: Int) {
        self.notificationID = notificationID
        self.message = message
        self.sentDate = sentDate
        self.userID = userID
    }
}
