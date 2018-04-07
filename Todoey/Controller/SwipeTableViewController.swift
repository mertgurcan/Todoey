//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Mert Gürcan on 7.04.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    
    var cell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70.0
    }
    
//    TablevView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        //gerekli yetki aktaran method
        guard orientation == .right else { return nil }
        
        
        
        let deleteAction = SwipeAction(style: .destructive , title: "Delete") { action, indexPath in
            print("delete cell")
            
            self.updateModel(at: indexPath)         
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "Delete-Icon.png")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    func updateModel(at indexPath: IndexPath ){
        
    }
    
}

