//
//  AddExpenseViewController.swift
//  Personal Expense Tracker - PROTOTYPE
//
//  Created by Joshua Norwood on 5/9/23.
//

import UIKit

let budgetCategoryAddedNotification = NSNotification.Name(rawValue: "budgetCategoryAdded")

class AddExpenseViewController: UIViewController {
    
    var currentUser: User?
    var selectedCategoryId: Int? // Add this line

    override func viewDidLoad() {
        super.viewDidLoad()
        previousExpensesPicker.dataSource = self
        previousExpensesPicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadCategoriesAndReloadPicker), name: budgetCategoryAddedNotification, object: nil)

    }
    
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBAction func saveExpenseButtonTapped(_ sender: UIButton) {
        let expense = expenseTextField.text ?? ""
        let amount = Double(amountTextField.text ?? "") ?? 0.0

        if let categoryId = selectedCategoryId {
            saveExpense(expense, amount: amount, categoryId: categoryId) // Pass the categoryId here

            let alertController = UIAlertController(title: "Expense Saved", message: "The Expense Has Been Saved.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var previousExpensesPicker: UIPickerView!
    
    func saveExpense(_ expense: String, amount: Double, categoryId: Int) {
        let newId = (currentUser?.expenses.last?.id ?? 0) + 1
        let currentDate = Date()
        let newExpense = Expense(id: newId, categoryId: categoryId, name: expense, amount: amount, date: currentDate)
        currentUser?.expenses.append(newExpense)

        if let categoryIndex = currentUser?.expenseCategories.firstIndex(where: { $0.id == categoryId }) {
            currentUser?.expenseCategories[categoryIndex].currentSpent += amount
        }

        DataStore.shared.saveUsers()
    }

    func loadCategories() -> [ExpenseCategory] {
        return currentUser?.expenseCategories ?? []
    }
}

extension AddExpenseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loadCategories().count
    }
    
    // UIPickerViewDelegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = loadCategories()[row]
        return "\(category.name)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categories = loadCategories()
        if !categories.isEmpty {
            let selectedCategory = categories[row]
            expenseTextField.text = selectedCategory.name
            selectedCategoryId = selectedCategory.id
        }
    }
    
    @objc func loadCategoriesAndReloadPicker() {
        previousExpensesPicker.reloadAllComponents()
    }

}
