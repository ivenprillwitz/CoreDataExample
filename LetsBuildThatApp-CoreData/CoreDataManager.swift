//
//  CoreDataManager.swift
//  LetsBuildThatApp-CoreData
//
//  Created by Iven Prillwitz on 22.06.18.
//  Copyright © 2018 Iven Prillwitz. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (storeDescription, error) in
            if error != nil {
                print("Error:" + error.debugDescription)
                return
            }
        }
        return container
    }()
}
