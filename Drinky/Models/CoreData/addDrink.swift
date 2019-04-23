//
//  addDrink.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

// method which adds the drink taken to the database
func addDrink(mililiters: Int16, completion: @escaping (Int) -> Void) {
    
    // get current time as date object
    let time = Date().format(format: "hh-mm-ss")
    
    // create the context
    guard let managedContext = AppVariables.appDelegate?.persistentContainer.viewContext else { return }
    
    // create a drink entity object
    let drink = Drink(context: managedContext)
    drink.time = time
    drink.mililiters = mililiters
    
    // get the current day entity
    let day = retrieveDayEntity()
    
    // update the day data
    let mlDrank = day?.value(forKey: "mlDrank") as? Int16
    let percentageGoal = calculatePercentageOfGoal(mililiters: mililiters, mililitersInDb: mlDrank ?? 0)
    
    print("Added drink percentage of goal: \(percentageGoal)")
    
    day?.setValuesForKeys(["mlDrank": (mlDrank ?? 0) + mililiters, "percentageGoal": percentageGoal])
    
    // set the day this drink was drank to the current day entity
    drink.dayDrank = day
    
    do {
        // try and save the changed data
        try managedContext.save()
        
        // if completed call the completion handler
        completion(percentageGoal)
    } catch {
        print("Could not create new day entity in database.")
    }
}
