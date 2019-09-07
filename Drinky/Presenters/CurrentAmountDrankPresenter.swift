//
//  CurrentAmountDrankPresenter.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 19/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import UIKit

class CurrentAmountDrankPresenter: PresenterProtocol {
    
    typealias viewControllerProtocol = CurrentAmountDrankViewControllerProtocol
    
    var view: CurrentAmountDrankViewControllerProtocol
    
    required init(view: CurrentAmountDrankViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        // set up the view
        view.setupMotion()
        view.setupView()
        
        // check if there has been any activity today
        checkIfDayEntity()
        
        // setup an observer for when the application goes to the foreground so we know when to update the views
        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        // setting initial userdefaults values if this is the initial launch
        if !SharedUserDefaults.shared.userDefaults!.bool(forKey: "launchedBefore") {
            print("initial launch")
            SharedUserDefaults.shared.userDefaults!.register(defaults: AppVariables.userDefaultsDefaultValues)
            SharedUserDefaults.shared.userDefaults!.set(true, forKey: "launchedBefore")
        }
    }
    
    // method which gets triggered when the applicatione enters the foreground, we need to update the ui then
    @objc func appCameToForeground() {
        checkIfDayEntity()
        view.setupView()
    }
    
    // method to fill the drink view on the screen
    func fillDrinkView(to: Double) {
        view.fillDrinkView(ml: to)
    }
    
    // method which gets called when a glass is tapped, adds a drink to the storage
    func addDrinkToData(ml: Int) {
        addDrink(mililiters: Double(ml)) { percentageGoal -> Void in
            self.fillDrinkView(to: percentageGoal) 
        }
    }
    
    // method which undoes the last taken drink
    func undoLastDrink() {
        let percentageGoal = undoDrinks()
        view.fillDrinkView(ml: percentageGoal)
    }
    
    // method to retrieve the current amount drank
    func getCurrentAmountDrank() -> String {
        let currentAmountDrank = retrieveDayEntity()?.mlDrank
        return String(currentAmountDrank ?? 0.0)
        
    }
    
    // method to retrieve the amount left to drink
    func getAmountLeftToDrink() -> String {
        let amountLeftToDrink = max(Double(SharedUserDefaults.shared.userDefaults!.integer(forKey: "recommendedAmount")) - (retrieveDayEntity()?.mlDrank ?? 0.0), 0)
        return String(amountLeftToDrink)
    }
    
    func willBecomeActive() {
        
    }
}
