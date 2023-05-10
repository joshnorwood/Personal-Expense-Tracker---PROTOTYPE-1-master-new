//
//  DataStore.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import Foundation


class DataStore {
    static let shared = DataStore()
    
    var users: [User] = []
    
    private init() {
        loadUsers()
    }
    
    func saveUsers() {
        let encoder = JSONEncoder()
        if let encodedUsers = try? encoder.encode(users) {
            UserDefaults.standard.set(encodedUsers, forKey: "users")
        }
    }
    
    func loadUsers() {
        if let savedUsers = UserDefaults.standard.object(forKey: "users") as? Data {
            let decoder = JSONDecoder()
            if let loadedUsers = try? decoder.decode([User].self, from: savedUsers) {
                users = loadedUsers
            }
        }
    }
    
    func getUser(userID: Int) -> User? {
        return users.first(where: { $0.userID == userID })
    }

    
    func getUser(email: String, password: String) -> User? {
        return users.first(where: { $0.email == email && $0.password == password })
    }

}

