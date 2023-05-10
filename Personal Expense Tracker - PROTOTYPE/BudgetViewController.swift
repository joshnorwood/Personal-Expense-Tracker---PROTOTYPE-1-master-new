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
    
    var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
    }

    func updateLabels() {
        let totalBudget = currentUser.expenseCategories.reduce(0.0) { $0 + $1.budgetAmount }
        let totalExpenses = currentUser.expenseCategories.reduce(0.0) { $0 + $1.currentSpent }
        let remainingBalance = totalBudget - totalExpenses

        totalBudgetLabel.text = String(format: "$%.2f", totalBudget)
        totalExpensesLabel.text = String(format: "$%.2f", totalExpenses)
        remainingBalanceLabel.text = String(format: "$%.2f", remainingBalance)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser.expenseCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = currentUser.expenseCategories[indexPath.row]
        cell.textLabel?.text = category.name

        // Calculate the balance left for the individual budgeted item
        let balance = category.budgetAmount - category.currentSpent
        let balanceText = String(format: "$%.2f", balance)

        // Set the balance text to the detailTextLabel of the cell
        cell.detailTextLabel?.text = balanceText

        return cell
    }
}
