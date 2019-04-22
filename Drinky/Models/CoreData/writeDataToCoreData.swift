//
//  writeDataToCoreData.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 20/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

func writeDataToStorage(mililitersDrank: Int) {
    
    // get current date
    let date = Date().format(format: "dd-MM-yyyy")
    
    guard let managedContext = AppVariables.appDelegate?.persistentContainer.viewContext else { return }
    
    let day = Day(context: managedContext)
    day.date = date
    day.mlDrank = 1000
    day.percentageGoal = 80
    
    let drink = Drink(context: managedContext)
    drink.dayDrank = day
    drink.mililiters = 1000
    drink.time = Date().format(format: "hh-mm")
    
    day.addToDrinkTaken(drink)

    do {
        try managedContext.save()
    } catch {
        
    }
}


