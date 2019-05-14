//
//  calculateRecommendedAmount.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 14/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

func calculateRecommendedAmount(weight: Int, excersize: Int) {
    
    let userDefaults = UserDefaults.standard
    
    var amountOfWater: Double = Double(weight) * 175/4
    
    if excersize > 0 {
        amountOfWater += Double(excersize) * 35/3
    }
    
    userDefaults.set(Int(amountOfWater*0.8), forKey: "recommendedAmount")
}
