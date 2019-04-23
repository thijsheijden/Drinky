//
//  CurrentAmountDrankPresenter.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 19/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

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
    }
    
    // method to fill the drink view on the screen
    func fillDrinkView(to: Int) {
        view.fillDrinkView(ml: to)
    }
    
    // method which gets called when a glass is tapped, adds a drink to the storage
    func addDrinkToData(ml: Int) {
        addDrink(mililiters: Int16(ml)) { percentageGoal -> Void in
            self.fillDrinkView(to: percentageGoal)
        }
    }
    
    // method which undoes the last taken drink
    func undoLastDrink() {
        let percentageGoal = undoDrinks()
        view.fillDrinkView(ml: Int("\(percentageGoal)") ?? 0)
    }
}
