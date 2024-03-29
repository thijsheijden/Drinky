//
//  createNewDayEntity.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

// this method creates a new day entity in the database. It is called when the app see's there is no day entity for the current day.
func createNewDayEntity() {
    
    // get current date
    let date = Date().format(format: "dd-MM-yyyy")
    
    // create a new day entity object
    let day = Day(context: CoreDataManager.shared.context)
    day.date = date
    day.mlDrank = 0
    day.percentageGoal = 0
    
    CoreDataManager.shared.save()
}
