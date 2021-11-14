//
//  CoredataManger.swift
//  TodoList.Capston
//
//  Created by Areej Mohammad on 02/04/1443 AH.
//

import CoreData

class CoreDataManger {
    let persistentContainer : NSPersistentContainer
    static let shared : CoreDataManger = CoreDataManger()
    init (){
        persistentContainer = NSPersistentContainer(name: "listdatabace")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load data\(error.localizedDescription)")
            }
        }
    }
}
