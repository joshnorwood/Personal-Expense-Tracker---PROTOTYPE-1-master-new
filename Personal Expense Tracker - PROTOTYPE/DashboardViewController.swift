//
//  DashboardViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 4/12/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var currentUser: User?

    @IBOutlet weak var totalIncomeLabel: UILabel!
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loggedInUserID = UserDefaults.standard.value(forKey: "loggedInUserID") as? Int {
            currentUser = DataStore.shared.getUser(userID: loggedInUserID)
        }
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
    }

    func updateLabels() {
        guard let currentUser = currentUser else { return }

        let occupation = currentUser.occupation
        let salary = currentUser.salary
        let expenses = currentUser.expenses

        // Calculate total expenses
        // Calculate total expenses
        var totalExpenses = 0.0
        for expense in expenses {
            totalExpenses += expense.amount
        }


        // Calculate net income
        let netIncome = salary - totalExpenses

        // Update UI
        totalIncomeLabel.text = "Income: $\(salary)"
        totalExpensesLabel.text = "Total Expenses: $\(totalExpenses)"
        balanceLabel.text = "Current Balance: $\(netIncome)"
    }

    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let addMenu = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        
        let addIncomeAction = UIAlertAction(title: "Add Income", style: .default) { (action) in
            // Segue to AddIncomeViewController
            self.performSegue(withIdentifier: "showAddIncome", sender: self)
        }
        
        let addExpenseAction = UIAlertAction(title: "Add Expense", style: .default) { (action) in
            // Segue to AddExpenseViewController
            self.performSegue(withIdentifier: "showAddExpense", sender: self)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addMenu.addAction(addIncomeAction)
        addMenu.addAction(addExpenseAction)
        addMenu.addAction(cancelAction)
        
        present(addMenu, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddIncome" {
            let addIncomeVC = segue.destination as? AddIncomeViewController
            addIncomeVC?.currentUser = currentUser
        } else if segue.identifier == "showAddExpense" {
            let addExpenseVC = segue.destination as? AddExpenseViewController
            addExpenseVC?.currentUser = currentUser
        }
    }

}
