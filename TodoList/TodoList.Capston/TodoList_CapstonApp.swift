//
//  TodoList_CapstonApp.swift
//  TodoList.Capston
//
//  Created by Areej Mohammad on 02/04/1443 AH.
//

import SwiftUI

@main
struct TodoList_CapstonApp: App {
    let persistentContainer = CoreDataManger.shared.persistentContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
