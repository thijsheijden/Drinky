//
//  SettingsPresenter.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 14/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation

class SettingsPresenter: PresenterProtocol {
    
    typealias viewControllerProtocol = SettingsViewControllerProtocol
    
    var view: SettingsViewControllerProtocol
    
    required init(view: SettingsViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
    }
    
    func updateRecommendedWaterIntakeLabel() {
        view.updateRecommendedAmountOfWaterLabelText(text: String(UserDefaults.standard.integer(forKey: "recommendedAmount")))
        
    }
}
