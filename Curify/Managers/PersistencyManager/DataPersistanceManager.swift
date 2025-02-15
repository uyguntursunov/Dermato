//
//  PersistencyManager.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 24/02/24.
//

import Foundation

class PersistencyManager {
    
    func saveData() {
        var person = NSEntityDescription.insertNewObjectForEntityForName("Person",
        inManagedObjectContext: self.managedObjectContext!) as Person
        person.name = "Mary"
        person.age = Float(arc4random() % 100)

        var error : NSError? = nil
        if !self.managedObjectContext!.save(&error) {
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
    }
}
