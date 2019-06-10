//
//  calculatePercentageOfGoal.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import CoreData

// method which calculates the percentage of the goal the user has achieved
func calculatePercentageOfGoal(mililiters: Double, mlInDb: Double = retrieveDayEntity()?.mlDrank ?? 0.0) -> Double {
    return Double(((mlInDb + mililiters) / Double(SharedUserDefaults.shared.userDefaults!.integer(forKey: "recommendedAmount")) * 100))
}
