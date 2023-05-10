//
//  NotificationsViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import UIKit

class NotificationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    struct AppNotification: Codable {
        let message: String
        let type: String // 'info', 'warning', or 'error'
    }

    func saveNotification(_ notification: AppNotification) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notification),
           var notificationsData = UserDefaults.standard.array(forKey: "notifications") as? [Data] {
            notificationsData.append(encoded)
            UserDefaults.standard.set(notificationsData, forKey: "notifications")
        }
    }

    func loadNotifications() -> [AppNotification] {
        let decoder = JSONDecoder()
        if let notificationsData = UserDefaults.standard.array(forKey: "notifications") as? [Data] {
            return notificationsData.compactMap { try? decoder.decode(AppNotification.self, from: $0) }
        }
        return []
    }

    

   
    }
