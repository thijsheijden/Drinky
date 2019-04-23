//
//  calculatePercentageOfGoal.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 23/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

// method which calculates the percentage of the goal the user has achieved
func calculatePercentageOfGoal(mililiters: Double, mililitersInDb: Double) -> Double {
    return Double(((mililitersInDb + mililiters) / AppVariables.goal) * 100)
}
