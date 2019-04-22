//
//  retrieveData.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 22/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

func retrieveDayEntity() {
    
    let managedContext = AppVariables.appDelegate?.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [Date().format(format: "dd-MM-yyyy")])
    
    do {
        
        let result = try managedContext?.fetch(fetchRequest)
        for data in result as! [NSManagedObject] {
            print(data.value(forKey: "percentageGoal") as! Float)
        }
        
    } catch {
        print("Failed")
    }
    
}
