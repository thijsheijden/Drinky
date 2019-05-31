//
//  NotificationSettingsViewController.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 31/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit

protocol NotificationSettingsViewControllerProtocol {
    
}

class NotificationSettingsViewController: UIViewController, NotificationSettingsViewControllerProtocol {
    
    var presenter: NotificationSettingsPresenter!

    @IBOutlet weak var fromTimePickerView: UIDatePicker!
    @IBOutlet weak var toTimePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the presenter
        presenter = NotificationSettingsPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
    
}

// MARK: All the time picker code
extension NotificationSettingsViewController {
    
}
