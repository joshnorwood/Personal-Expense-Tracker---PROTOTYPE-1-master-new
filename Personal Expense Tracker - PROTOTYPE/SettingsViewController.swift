//
//  SettingsViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/13/23.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "currentUserId")
        DataStore.shared.saveUsers()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        UIApplication.shared.windows.first?.rootViewController = loginVC
    }


    

}
