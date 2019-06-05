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
    var rangeSlider: NotificationRangeSlider!

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
        
        setupRangeSlider()
    }
    
    // setting up the range slider
    func setupRangeSlider() {
        rangeSlider = NotificationRangeSlider(frame: CGRect(x: view.frame.minX + 25, y: view.center.y, width: view.frame.width - 50, height: 250))
        rangeSlider.backgroundColor = .clear
        self.view.addSubview(rangeSlider)
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
