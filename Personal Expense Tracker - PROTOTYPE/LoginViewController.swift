//
//  LoginViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/13/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        if let currentUser = DataStore.shared.getUser(email: email, password: password) {
            UserDefaults.standard.set(currentUser.userID, forKey: "loggedInUserID")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
            
            if let dashboardNavigationVC = tabBarVC.viewControllers?.first as? UINavigationController,
               let dashboardVC = dashboardNavigationVC.topViewController as? DashboardViewController {
                dashboardVC.currentUser = currentUser
            }
            
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        } else {
            showAlert(title: "Error", message: "Invalid email or password.")
        }
    }



    //Alerts
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

