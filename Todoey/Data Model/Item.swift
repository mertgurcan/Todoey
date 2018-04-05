//
//  Item.swift
//  Todoey
//
//  Created by Mert Gürcan on 4.04.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    
    //forward relationship initilaze
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
