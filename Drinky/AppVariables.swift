//
//  AppVariables.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 22/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import UIKit

class AppVariables {
    // create a UserDefaults object which can be shared across target containers
    static let sharedUserDefaults = SharedUserDefaults.shared.userDefaults
}

// MARK: All the UserDefaults data
extension AppVariables {
    
    static let userDefaultsDefaultValues = [
        "notificationsStartTime" : 7,
        "notificationsEndTime" : 22,
        "notificationsIntervalHours" : 1,
        "notificationsIntervalMinutes" : 0,
        "userWeight" : 65,
        "excersizeMinutesDaily" : 15,
        "recommendedAmount" : 2500
    ]
    
    static var notifications: Bool {
        get {
            return sharedUserDefaults!.bool(forKey: "notificationsToggled")
        } set {
            sharedUserDefaults!.set(newValue, forKey: "notificationsToggled")
        }
    }
    
    static var startTime: Int {
        get {
            return sharedUserDefaults!.integer(forKey: "notificationsStartTime")
        } set {
            sharedUserDefaults!.set(newValue, forKey: "notificationsStartTime")
        }
    }
    
    static var endTime: Int {
        get {
            return sharedUserDefaults!.integer(forKey: "notificationsEndTime")
        } set {
            sharedUserDefaults!.set(newValue, forKey: "notificationsEndTime")
        }
    }
    
    static var notificationIntervalHours: Int {
        get {
            return sharedUserDefaults!.integer(forKey: "notificationsIntervalHours")
        } set {
            sharedUserDefaults!.set(newValue, forKey: "notificationsIntervalHours")
            
        }
    }
    
    static var notificationIntervalMinutes: Int {
        get {
            return sharedUserDefaults!.integer(forKey: "notificationsIntervalMinutes")
        } set {
            sharedUserDefaults!.set(newValue, forKey: "notificationsIntervalMinutes")
        }
    }
}

// MARK: The enum for HealthKit status
extension AppVariables {
    enum healthKitStat {
        case notAvailable
        case notAuthorized
        case dataTypeNotAvailable
        case authorized
    }
}
