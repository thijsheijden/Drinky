//
//  checkIfDayEntity.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

// this method checks wether there is a day entity in the database with the date of today
func checkIfDayEntity() {
    
    let managedContext = AppVariables.appDelegate?.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [Date().format(format: "dd-MM-yyyy")])
    
    do {
        
        let result = try managedContext?.fetch(fetchRequest)
        
        // if the result is equal to an empty array, meaning there were no results, we need to create a new day entity
        if result?.count == 0 {
            createNewDayEntity()
        } else {
            print("day object already present")
        }
        
    } catch {
        print("Failed")
    }
    
}
