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
    
    // the app's appdelegate
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
}

// MARK: All the UserDefaults data
extension AppVariables {
    static var notifications: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "notificationsToggled")
        } set {
            UserDefaults.standard.set(newValue, forKey: "notificationsToggled")
        }
    }
    
    static var startTime: Int {
        get {
            return UserDefaults.standard.integer(forKey: "notificationsStartTime")
        } set {
            UserDefaults.standard.set(newValue, forKey: "notificationsStartTime")
        }
    }
    
    static var endTime: Int {
        get {
            return UserDefaults.standard.integer(forKey: "notificationsEndTime")
        } set {
            UserDefaults.standard.set(newValue, forKey: "notificationsEndTime")
        }
    }
    
    static var notificationIntervalHours: Int {
        get {
            return UserDefaults.standard.integer(forKey: "notificationsIntervalHours")
        } set {
            UserDefaults.standard.set(newValue, forKey: "notificationsIntervalHours")
            
        }
    }
    
    static var notificationIntervalMinutes: Int {
        get {
            return UserDefaults.standard.integer(forKey: "notificationsIntervalMinutes")
        } set {
            UserDefaults.standard.set(newValue, forKey: "notificationsIntervalMinutes")
            
        }
    }
}
