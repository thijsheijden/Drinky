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

    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var notificationTimeRangeLabel: UILabel!
    
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
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
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
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        notificationTimeRangeLabel.text = "Receive notifications from \((Int)(rangeSlider.lowerValue)):00 to \((Int)(rangeSlider.upperValue)):00"
        AppVariables.startTime = (Int)(rangeSlider.lowerValue)
        AppVariables.endTime = (Int)(rangeSlider.upperValue)
    }
}
