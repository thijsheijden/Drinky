//
//  SlideUpRoundedView.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 20/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit

protocol WaterGlassTappedDelegate {
    func waterGlassTapped(mililiters: Int)
    func closeButtonTapped()
}

class SlideUpRoundedView: UIView {

    @IBOutlet weak var customAmountDrankPicker: UIPickerView!

    var delegate: WaterGlassTappedDelegate?
    
    var pickerData: [Int] = [Int]()
    
    func setupView() {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        
        customAmountDrankPicker.delegate = self
        customAmountDrankPicker.dataSource = self
        customAmountDrankPicker.showsSelectionIndicator = true
        
        fillPicker()
    }
    
    // method which animates the view from the bottom of the screen
    func animateUp(x: Int, width: Int, y: Int) {
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                self.frame = CGRect(x: x, y: y - 15, width: width, height: 300)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.frame = CGRect(x: x, y: y, width: width, height: 300)
            }
        })
    }
    
    func animateOut(rect: CGRect, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.4, animations: {
            self.frame = rect
        }, completion: { (finished: Bool) in
            self.removeFromSuperview()
            completion()
        })
    }
    
    // MARK: All Actions
    @IBAction func smallGlassTapped(_ sender: Any) {
        delegate?.waterGlassTapped(mililiters: 150)
    }
    
    @IBAction func mediumGlassTapped(_ sender: Any) {
        delegate?.waterGlassTapped(mililiters: 250)
    }
    
    @IBAction func bigGlassTapped(_ sender: Any) {
        delegate?.waterGlassTapped(mililiters: 350)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate?.closeButtonTapped()
    }
    
    @IBAction func swipeDownOnSlideUpRoundedView(_ sender: Any) {
        print("swipe down")
        delegate?.closeButtonTapped()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let selectedAmountOfWater = pickerData[customAmountDrankPicker.selectedRow(inComponent: 0)]
        if selectedAmountOfWater > 0 {
            delegate?.waterGlassTapped(mililiters: selectedAmountOfWater)
        } else {
            delegate?.closeButtonTapped()
        }
    }
    
}

// extension conforming to the pickerview datasource and delegate
extension SlideUpRoundedView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // method which fills the picker with values
    func fillPicker() {
        for n in 0...20 {
            pickerData.append(n*50)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
}
