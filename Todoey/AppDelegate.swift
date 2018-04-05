//
//  AppDelegate.swift
//  Todoey
//
//  Created by Mert Gürcan on 28.03.2018.
//  Copyright © 2018 Mert Gürcan. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        let data = Data()
       
        do {
            let realm = try Realm()
        }catch{
            print("Error initialing realm, \(error)")
        }
       
        return true
    }

  
    
}





