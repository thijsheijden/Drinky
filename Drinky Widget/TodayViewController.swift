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
    @IBOutlet weak var percentageGoalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func updateUI() {
        // setting all the ui element values
        let today = retrieveDayEntity()
        if CGFloat(today?.percentageGoal ?? 0.0) / 100.0 > 1.0 {
            activityView.endArc = 1.0
        } else {
            activityView.endArc = CGFloat(today?.percentageGoal ?? 0.0) / 100.0
        }
        percentageGoalLabel.text = String(format: "%.1f", today?.percentageGoal ?? 0.0) + "%"
    }
    
    @IBAction func largeGlassPressed(_ sender: Any) {
        addDrink(mililiters: 350)
        print("large")
        updateUI()
    }
    
    @IBAction func mediumGlassPressed(_ sender: Any) {
        addDrink(mililiters: 250)
        print("medium")
        updateUI()
    }
    
    @IBAction func smallGlassPressed(_ sender: Any) {
        addDrink(mililiters: 150)
        print("small")
        updateUI()
    }
}
