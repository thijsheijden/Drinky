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
    
    var delegate: WaterGlassTappedDelegate?
    
    func setupView() {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
    
    // method which animates the view from the bottom of the screen
    func animateUp(x: Int, width: Int, y: Int) {
        
        UIView.animateKeyframes(withDuration: 0.75, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                self.frame = CGRect(x: x, y: y - 15, width: width, height: 175)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.frame = CGRect(x: x, y: y, width: width, height: 175)
            }
        })
    }
    
    func animateOut(rect: CGRect, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
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
    
}
