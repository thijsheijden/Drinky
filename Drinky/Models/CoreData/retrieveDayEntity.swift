//
//  retrieveData.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 22/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

func retrieveDayEntity() -> Day? {
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [Date().format(format: "dd-MM-yyyy")])
    
    do {
        
        let result = try CoreDataManager.shared.context.fetch(fetchRequest)
        for data in result as! [NSManagedObject] {
            return data as? Day
        }
        
    } catch {
        print("Failed")
    }
    
    return nil
    
}
