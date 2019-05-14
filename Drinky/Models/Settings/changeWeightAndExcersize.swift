//
//  changeWeightAndExcersize.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 14/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

// this method changes the weight and height of the user, also updating the goal of the user
func changeWeightAndExcersize(weight: Int = UserDefaults.standard.integer(forKey: "userWeight"), excersize: Int = UserDefaults.standard.integer(forKey: "excersizeMinutesDaily")) {
    let userDefaults = UserDefaults.standard
    
    // update user information
    userDefaults.set(weight, forKey: "userWeight")
    userDefaults.set(excersize, forKey: "excersizeMinutesDaily")
    
    calculateRecommendedAmount(weight: userDefaults.integer(forKey: "userWeight"), excersize: userDefaults.integer(forKey: "excersizeMinutesDaily"))
}
