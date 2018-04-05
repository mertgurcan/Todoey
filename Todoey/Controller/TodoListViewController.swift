//
//  ViewController.swift
//  Todoey
//
//  Created by Mert Gürcan on 28.03.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    
    let realm = try! Realm()
    var todoItems : Results<Item>?
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        if let item = todoItems?[indexPath.row]{
            
            cell.textLabel?.text = item.title
            //ternary operator
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items ADDED"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do  {
                try realm.write {
                    
                    item.done = !item.done
                }
            }
                catch {
                    print("Error saving done Status, \(error)")
                
                }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            //what will happen once the user clicks the add item button
            if let currentCategory = self.selectedCategory {
                do  {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch{
                    print("Error saving items, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func loadItems( ){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }
}
//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        
        tableView.reloadData()

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }


}

