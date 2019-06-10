//
//  NotificationManager.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 30/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        notificationCenter.delegate = self
        setupNotificationCategoriesAndActions()
    }
    
    // method which sets up the notification categories and actions at application launch
    func setupNotificationCategoriesAndActions() {
        
        // Define the custom actions.
        let drinkSmallGlassAction = UNNotificationAction(identifier: "drinkSmallGlassNotificationAction",
                                                title: "Drink Small Glass (150mL)",
                                                options: UNNotificationActionOptions(rawValue: 0))
        
        let drinkMediumGlassAction = UNNotificationAction(identifier: "drinkMediumGlassNotificationAction",
                                                 title: "Drink Normal Glass (250mL)",
                                                 options: UNNotificationActionOptions(rawValue: 0))
        
        let drinkLargeGlassAction = UNNotificationAction(identifier: "drinkLargeGlassNotificationAction",
                                                          title: "Drink Large Glass (350mL)",
                                                          options: UNNotificationActionOptions(rawValue: 0))
        
        // Define the notification type
        let takeDrinkNotificationActionCategory =
            UNNotificationCategory(identifier: "takeDrinkNotificationCategory",
                                   actions: [drinkSmallGlassAction, drinkMediumGlassAction, drinkLargeGlassAction],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)
        
        // Register the notification type.
        notificationCenter.setNotificationCategories([takeDrinkNotificationActionCategory])
    }

    // method which returns wether the user allowed notifications, and can then call another method
    func checkPermission(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .denied || settings.authorizationStatus == .notDetermined {
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
    // method to ask user permission to send notification
    func askPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: {
            (granted, error) in
        })
    }
    
    // method to schedule the next notifications (and remove the old ones from the schedule)
    func prepareNextNotifications() {
        if AppVariables.notifications {
            print("Preparing notification")
            
            removeAllPendingNotifications()
            
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            
            // setting the content of the notification
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Time to drink something.", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "It seems like you haven't drank anything in the past hour, remember to keep your body hydrated!", arguments: nil)
            content.categoryIdentifier = "takeDrinkNotificationCategory"
            
            // Schedule the notification in the next interval
            if checkIfNextNotificationFits() {
                dateComponents.hour = Calendar.current.component(.hour, from: Date()) + 1
                dateComponents.minute = Calendar.current.component(.minute, from: Date())
            } else {
                dateComponents.day = Calendar.current.component(.day, from: Date()) + 1
                dateComponents.hour = AppVariables.startTime
            }
            
            // Create the trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content, trigger: trigger)
            
            notificationCenter.add(request, withCompletionHandler: nil)
        }
    }
    
    // remove all the pending notifications from the notification queue
    func removeAllPendingNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    // MARK: Methods to change the state of notifications
    func toggleNotifications(on: Bool) {
        AppVariables.notifications = on
        if(on) {
            prepareNextNotifications()
        } else {
            removeAllPendingNotifications()
        }
    }
    
    // MARK: Method which checks if the next hour falls within the set notification range
    func checkIfNextNotificationFits() -> Bool {
        if(Calendar.current.component(.hour, from: Date()) + 1 <= AppVariables.endTime) {
            print(true)
            return true
        }
        return false
    }
    
    // check wether there are scheduled notifications
    func checkWetherThereAreNoScheduledNotifications(completion: @escaping (Bool) -> Void) {
        notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            completion(requests.isEmpty)
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "drinkSmallGlassNotificationAction":
            addDrink(mililiters: 150)
        case "drinkMediumGlassNotificationAction":
            addDrink(mililiters: 250)
        case "drinkLargeGlassNotificationAction":
            addDrink(mililiters: 350)
        default:
            addDrink(mililiters: 1000)
        }
        prepareNextNotifications()
        completionHandler()
    }
}
