//
//  BudgetViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import UIKit

class BudgetViewController: UIViewController, UITableViewDataSource {
    
    let budgetCategoryAddedNotification = NSNotification.Name(rawValue: "budgetCategoryAdded")

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalBudgetLabel: UILabel!
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var remainingBalanceLabel: UILabel!
    
    var currentUser: User!

    override func viewDidLoad() {
        DataStore.shared.loadUsers()
        currentUser = DataStore.shared.users.first
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabels), name: budgetCategoryAddedNotification, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
    }

    @objc func updateLabels() {
        let totalBudget = currentUser.expenseCategories.reduce(0.0) { $0 + $1.budgetAmount }
        let totalExpenses = currentUser.expenses.reduce(0.0) { $0 + $1.amount }
        let remainingBalance = totalBudget - totalExpenses

        totalBudgetLabel.text = String(format: "$%.2f", totalBudget)
        totalExpensesLabel.text = String(format: "$%.2f", totalExpenses)
        remainingBalanceLabel.text = String(format: "$%.2f", remainingBalance)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
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
                    DataStore.shared.saveUsers()
                    NotificationCenter.default.post(name: budgetCategoryAddedNotification, object: nil)

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

        let balance = category.budgetAmount - category.currentSpent
        let balanceText = String(format: "$%.2f", balance)

       
        cell.detailTextLabel?.text = balanceText

        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentUser.expenseCategories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateLabels()
            DataStore.shared.saveUsers()
        }
    }

}
