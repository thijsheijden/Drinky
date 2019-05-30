//
//  TodayViewController.swift
//  Drinky Widget
//
//  Created by Thijs van der Heijden on 30/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var activityView: ActivityArcView!
    @IBOutlet weak var amountDrankLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting all the ui element values
        let today = retrieveDayEntity()
        activityView.endArc = CGFloat(today?.percentageGoal ?? 0.0) / 100.0
        amountDrankLabel.text = String(today?.drinkTaken?.count ?? 0)
        
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
