//
//  SettingsViewController.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 14/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func setupView()
    func updateRecommendedAmountOfWaterLabelText(text: String)
}

class SettingsViewController: UIViewController, SettingsViewControllerProtocol {

    // MARK: IBOutlets
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var excersizePicker: UIPickerView!
    
    @IBOutlet weak var recommendedAmountLabel: UILabel!
    
    // MARK: Constants and variables
    var presenter: SettingsPresenter!
    var weightArray = [Int]()
    var excersizeArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SettingsPresenter(view: self)
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupView() {
        fillWeightArray()
        fillExcersizeArray()
        
        presenter.updateRecommendedWaterIntakeLabel()
        
        recommendedAmountLabel.adjustsFontSizeToFitWidth = true
        
        weightPicker.dataSource = self
        weightPicker.delegate = self
        
        excersizePicker.dataSource = self
        excersizePicker.delegate = self
        
        weightPicker.selectRow(UserDefaults.standard.integer(forKey: "userWeight"), inComponent: 0, animated: true)
        excersizePicker.selectRow((UserDefaults.standard.integer(forKey: "excersizeMinutesDaily")/5), inComponent: 0, animated: true)
    }
    
    func updateRecommendedAmountOfWaterLabelText(text: String) {
        recommendedAmountLabel.text = "Recommended daily intake: \(text) mL"
    }

}

// extension to conform to picker delegate and datasource
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func fillWeightArray() {
        for i in 0...250 {
            weightArray.append(i)
        }
    }
    
    func fillExcersizeArray() {
        for i in 0...96 {
            excersizeArray.append(i*5)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return weightArray.count
        } else {
            return excersizeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return String(weightArray[row])
        } else {
            return String(excersizeArray[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            changeWeightAndExcersize(weight: weightArray[row])
            presenter.updateRecommendedWaterIntakeLabel()
        } else {
            changeWeightAndExcersize(excersize: excersizeArray[row])
            presenter.updateRecommendedWaterIntakeLabel()
        }
    }
    
}
