//
//  BudgetViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import UIKit

class BudgetViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalBudgetLabel: UILabel!
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var remainingBalanceLabel: UILabel!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        updateLabels()
    }
    
    func updateLabels() {
        let totalBudget = currentUser.expenseCategories.reduce(0.0) { $0 + $1.budgetAmount }
        let totalExpenses = currentUser.expenseCategories.reduce(0.0) { $0 + $1.currentSpent }
        let remainingBalance = totalBudget - totalExpenses

        totalBudgetLabel.text = String(format: "%.2f", totalBudget)
        totalExpensesLabel.text = String(format: "%.2f", totalExpenses)
        remainingBalanceLabel.text = String(format: "%.2f", remainingBalance)
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Expense Category", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Category Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Budget Amount"
            textField.keyboardType = .decimalPad
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let name = alertController.textFields?[0].text,
               let budgetAmountText = alertController.textFields?[1].text,
               let budgetAmount = Double(budgetAmountText) {
                let newCategory = ExpenseCategory(id: self.currentUser.expenseCategories.count + 1, name: name, budgetAmount: budgetAmount)
                self.currentUser.expenseCategories.append(newCategory)
                self.tableView.reloadData()
                self.updateLabels()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentUser.expenseCategories.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            let category = currentUser.expenseCategories[indexPath.row]
            cell.textLabel?.text = category.name
            cell.detailTextLabel?.text = String(format: "%.2f", category.budgetAmount)
            return cell
        }
    }
