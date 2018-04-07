//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mert Gürcan on 2.04.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    
    //initilazing Realm
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadCategories()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "1D9BF6")
        
    }
    
    //MARK: - tableview datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath) 
      
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        cell.backgroundColor = UIColor(hexString:  categories?[indexPath.row].colour ?? "1D9BF6")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
    }
    

    //MARK: - add new categories 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            //what will happen once the user clicks the add item button
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - data manuplatiobn method
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving context")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
       
        tableView.reloadData()
        
    }
    //MARK: - Delete Data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch {
                print("Swipe Error \(error)")
            }
        }
    }

}

