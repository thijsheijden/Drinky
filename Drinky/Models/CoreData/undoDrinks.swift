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
func undoDrinks() -> Double {
    
    var lastInsertedTime: Date!
    var toDeleteDrink: Drink!
    
    // getting the day object for today
    let day = retrieveDayEntity()
    
    // removing the last added drink from the day object
    guard let drinks = day?.drinkTaken else { return 0 }
    
    print(drinks.count)
    
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
                    print(toDeleteDrink.mililiters)
                }
                
            }
        }

        day?.removeFromDrinkTaken(toDeleteDrink)
        CoreDataManager.shared.context.delete(toDeleteDrink)
        
        // calculate the new percentageGoal and pass it back
        let percentageGoal = calculatePercentageOfGoal(mililiters: -(toDeleteDrink.mililiters), mlInDb: day?.mlDrank ?? 0.0)
        
        day?.mlDrank -= toDeleteDrink.mililiters
        day?.percentageGoal = percentageGoal
                
        CoreDataManager.shared.save()
        
        return percentageGoal

    }
    
    return 0.0
}
