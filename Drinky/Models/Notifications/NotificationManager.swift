//
//  NotificationManager.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 30/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    private init() {}
    
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    // method which returns wether the user allowed notifications, and can then call another method
    func checkPermission(completion: (() -> Void)? = nil) {
        notificationCenter.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .denied || settings.authorizationStatus == .notDetermined {
                self.askPermission()
            } else {
                if(completion != nil) {
                    completion!()
                }
            }
        })
    }
    
    // method to ask user permission to send notification
    func askPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: {
            (granted, error) in
            print(granted)
        })
    }
    
    // method to schedule the next notifications (and remove the old ones from the schedule)
    func prepareNextNotifications() {
        notificationCenter.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .authorized {
                // set notifications
            } else {
                self.askPermission()
            }
        })
    }
}
