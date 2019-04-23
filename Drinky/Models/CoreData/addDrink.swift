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
func addDrink(mililiters: Double, completion: @escaping (Double) -> Void) {
    
    // get current time as date object
    let time = Date().format(format: "hh-mm-ss")
    
    // create a drink entity object
    let drink = Drink(context: CoreDataManager.shared.context)
    drink.time = time
    drink.mililiters = mililiters
    
    // get the current day entity
    let day = retrieveDayEntity()
    
    // update the day data
    let mlDrank = day?.mlDrank
    
    let percentageGoal = calculatePercentageOfGoal(mililiters: mililiters, mililitersInDb: mlDrank ?? 0.0)
    
    print("Added drink percentage of goal: \(percentageGoal)")
    
    day?.mlDrank += mililiters
    day?.percentageGoal = percentageGoal
    
    // set the day this drink was drank to the current day entity
    day?.addToDrinkTaken(drink)
    
    CoreDataManager.shared.save()
    completion(percentageGoal)
}
