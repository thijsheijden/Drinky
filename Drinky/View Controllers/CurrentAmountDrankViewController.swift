//
//  CurrentAmountDrankViewController
//  Drinky
//
//  Created by Thijs van der Heijden on 19/04/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit
import BAFluidView
import CoreMotion

class CurrentAmountDrankViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var amountDrankView: BAFluidView!
    
    // variables and constants
    var slideUpView: SlideUpRoundedView!
    var motionManager = CMMotionManager()
    
    // constants to keep track of the minimal y of the screen
    var screenMinY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        screenMinY = self.view.frame.maxY
        
        setupMotion()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        amountDrankView.startTiltAnimation()
    }
    
    // method which creates the CMMotionManager and posts notifications
    func setupMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.3
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { data, error in
                var userInfo: [AnyHashable : Any]? = nil
                if let data = data {
                    userInfo = ["data" : data]
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: kBAFluidViewCMMotionUpdate), object: self, userInfo: userInfo)
            })
        }
    }
    
    func setupLiquidBackgroundView(fillTo: NSNumber) {
        print(fillTo)
        amountDrankView.fillColor = UIColor(hex: 0x397ebe)
        amountDrankView.fillRepeatCount = 1
        amountDrankView.fillAutoReverse = false
        amountDrankView.fill(to: fillTo)
        amountDrankView.startAnimation()
    }
    
    // setting up the view based on the results
    func setupView() {
        setupLiquidBackgroundView(fillTo: 0.4)
    }
    
    func setupSlideUpView() {
        slideUpView = Bundle.main.loadNibNamed("SlideUpRoundedView", owner: self, options: nil)!.first as? SlideUpRoundedView
        slideUpView.frame = CGRect(x: 25, y: screenMinY + 250, width: self.view.frame.width - 50, height: 175)
        slideUpView.setupView()
        slideUpView.delegate = self
        self.view.addSubview(slideUpView)
        slideUpView.animateUp(x: 25, width: Int(self.view.frame.width - 50), y: Int(screenMinY - 250))
    }
    
    func removeSlideUpView() {
        slideUpView.animateOut(rect: CGRect(x: 25, y: screenMinY + 250, width: self.view.frame.width - 50, height: 175), completion: { () -> Void in
            self.slideUpView = nil
        })
    }
    
    // MARK: All Actions
    @IBAction func drinkButtonPressed(_ sender: Any) {
        if slideUpView != nil {
            removeSlideUpView()
        } else {
            setupSlideUpView()
            amountDrankView.fill(to: 0.6)
        }
    }
    
}

extension CurrentAmountDrankViewController: WaterGlassTappedDelegate {
    func waterGlassTapped(mililiters: Int) {
        print(mililiters)
        retrieveDayEntity()
        removeSlideUpView()
    }
    
    func closeButtonTapped() {
        removeSlideUpView()
    }
}

