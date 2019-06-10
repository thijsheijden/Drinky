//
//  SharedUserDefaults.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 10/06/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

class SharedUserDefaults {
    
    private init() {}
    
    static let shared = SharedUserDefaults()
    
    var userDefaults = UserDefaults(suiteName: "group.eu.thijsvanderheijden.Drinky")
}
