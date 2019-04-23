//
//  undoDrinks.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

// this method undoes the last drink taken
func undoDrinks() -> Int16? {
    
    var lastInsertedTime: Date!
    var toDeleteDrink: Drink!
    
    // getting the day object for today
    let day = retrieveDayEntity()
    
    // removing the last added drink from the day object
    guard let drinks = day?.drinkTaken else { return 0 }
    
    if drinks.count > 0 {
        for drinkTaken in drinks {
            
            if let drink = drinkTaken as? Drink {
                                
                if lastInsertedTime == nil {
                    lastInsertedTime = drink.time
                }
                
                // look at which has the most recent time, if more recent than the previous most recent, override that value and change the toRemove value to the new drink value
                if drink.time! >= lastInsertedTime! {
                    lastInsertedTime = drink.time
                    toDeleteDrink = drink
                }
                
            }
        }

        day?.removeFromDrinkTaken(toDeleteDrink)
        
        day?.setValue(0, forKey: "percentageGoal")
        
        // calculate the new percentageGoal and pass it back
        let percentageGoal = calculatePercentageOfGoal(mililiters: 0, mililitersInDb: day?.mlDrank ?? 0 - toDeleteDrink.mililiters)
//        day?.setValuesForKeys(["mlDrank": day?.mlDrank ?? 0 - toDeleteDrink.mililiters, "percentageGoal": 0])
//        print("Undo curent percentage goal: \(day?.percentageGoal), mlDrank: \(day?.mlDrank)")
        
        return Int16(percentageGoal)

    }
    
    return 0
}
