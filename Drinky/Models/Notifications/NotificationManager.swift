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
    
    private override init() {
        super.init()
        notificationCenter.delegate = self
        print("initialized")
    }
    
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
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
        print("Preparing notification")
        
        // setting the content of the notification
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Time to drink something.", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "It seems like you haven't drank anything in the past hour, remember to keep your body hydrated!", arguments: nil)
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        // Schedule the notification in the next hour
        if checkIfNextNotificationFits() {
//                    dateComponents.hour = Calendar.current.component(.hour, from: Date()) + 1
            dateComponents.second = Calendar.current.component(.second, from: Date()) + 5
        } else {
            // if the notification in the next hour doesnt fit in the range, schedule it for the next morning at start time
//                    dateComponents.day = Calendar.current.component(.day, from: Date()) + 1
//                    dateComponents.hour = AppVariables.startTime
        }
        
        // Create the trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if(error != nil) {
                // Do something with this error?
                print(error)
            }
        })
    }
    
    func turnOffNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    // MARK: Methods to change the state of notifications
    func toggleNotifications(on: Bool) {
        if(on) {
            print("turned notifications on")
            prepareNextNotifications()
        } else {
            turnOffNotifications()
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
    
    // MARK: Delegate code, catching when a notification has been sent out, to register another one
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        prepareNextNotifications()
        completionHandler()
    }
}
