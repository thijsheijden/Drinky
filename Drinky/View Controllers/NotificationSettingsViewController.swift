//
//  NotificationSettingsViewController.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 31/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit

protocol NotificationSettingsViewControllerProtocol {
    func setupView()
}

class NotificationSettingsViewController: UIViewController, NotificationSettingsViewControllerProtocol {
    
    var presenter: NotificationSettingsPresenter!

    @IBOutlet weak var fromTimePickerView: UIDatePicker!
    @IBOutlet weak var toTimePickerView: UIDatePicker!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the presenter
        presenter = NotificationSettingsPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Setting up the view
    func setupView() {
        if AppVariables.notifications {
            notificationsSwitch.isOn = true
        } else {
            notificationsSwitch.isOn = false
        }
    }

    // MARK: Value changed for both of the picker views
    @IBAction func fromTimeChanged(_ sender: Any) {
        let picker = sender as! UIDatePicker
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        print(formatter.string(from: picker.date))
    }
    
    @IBAction func toTimeChanged(_ sender: Any) {
        let picker = sender as! UIDatePicker
        let time = picker.date.format(format: "hh-mm-ss")
    }
    
    @IBAction func notificationsToggled(_ sender: Any) {
        let toggle: Bool = notificationsSwitch.isOn
        NotificationManager.shared.checkPermission(completion: { (allowed) in
            if allowed {
                NotificationManager.shared.toggleNotifications(on: toggle)
            } else {
                NotificationManager.shared.askPermission()
            }
        })
    }
}

// MARK: All the time picker code
extension NotificationSettingsViewController {
    
}
