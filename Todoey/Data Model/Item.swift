//
//  Item.swift
//  Todoey
//
//  Created by Mert Gürcan on 31.03.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import Foundation

//Encodable means item type can encode himself to json or plist
class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
