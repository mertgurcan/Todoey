//
//  Category.swift
//  Todoey
//
//  Created by Mert Gürcan on 4.04.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var  name : String = ""
    let items = List<Item>()
}
