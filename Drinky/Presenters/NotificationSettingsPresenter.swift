//
//  NotificationSettingsPresenter.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 31/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

class NotificationSettingsPresenter: PresenterProtocol {
    
    typealias viewControllerProtocol = NotificationSettingsViewControllerProtocol
    
    var view: NotificationSettingsViewControllerProtocol
    
    required init(view: NotificationSettingsViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
    }
    
    // update the userDefaults values for notification times
    func updateNotificationTimeRange() {
        
    }
}
