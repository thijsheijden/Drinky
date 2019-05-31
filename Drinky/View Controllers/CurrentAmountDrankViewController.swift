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

protocol CurrentAmountDrankViewControllerProtocol {
    func setupView()
    func setupMotion()
    func fillDrinkView(ml: Double)
}

class CurrentAmountDrankViewController: UIViewController, CurrentAmountDrankViewControllerProtocol {

    // IBOutlets
    @IBOutlet weak var amountDrankView: BAFluidView!
    @IBOutlet weak var amountDrankLabel: UILabel!
    @IBOutlet weak var amountLeftToDrinkLabel: UILabel!
    
    // variables and constants
    var slideUpView: SlideUpRoundedView!
    var motionManager = CMMotionManager()
    var presenter: CurrentAmountDrankPresenter!
    
    // constants to keep track of the minimal y of the screen
    var screenMinY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        screenMinY = self.view.frame.maxY

        presenter = CurrentAmountDrankPresenter(view: self)
        presenter.viewDidLoad()
        
        if UserDefaults.standard.integer(forKey: "userWeight") == 0 {
            addInitialUserDefaultsValues()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        amountDrankView.fill(to: calculatePercentageOfGoal(mililiters: 0) / 100 as NSNumber)
        setLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        amountDrankView.startTiltAnimation()
    }
    
    // MARK: Remove when initial onboarding has been added
    func addInitialUserDefaultsValues() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(65, forKey: "userWeight")
        userDefaults.set(30, forKey: "excersizeMinutesDaily")
        userDefaults.set(3000, forKey: "recommendedAmount")
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
    
    // setting up all the views on initial load of view controller
    func setupView() {
        setupLiquidBackgroundView()
        setLabels()
    }
    
    // setting up the liquid animated background view
    func setupLiquidBackgroundView() {
        amountDrankView.fillColor = UIColor(hex: 0x397ebe)
        amountDrankView.fillRepeatCount = 1
        amountDrankView.fillAutoReverse = false
        amountDrankView.fill(to: (retrieveDayEntity()?.percentageGoal ?? 0.0) / 100 as NSNumber?)
        amountDrankView.startAnimation()
    }
    
    // method which sets both drink labels
    func setLabels() {
        setCurrentAmountDrankLabelText(text: presenter.getCurrentAmountDrank())
        setAmountLeftToGoLabelText(text: presenter.getAmountLeftToDrink())
        
        amountDrankLabel.adjustsFontSizeToFitWidth = true
        amountLeftToDrinkLabel.adjustsFontSizeToFitWidth = true
    }
    
    // method to set the current amount drank label
    func setCurrentAmountDrankLabelText(text: String) {
        amountDrankLabel.text = "\(text) mL"
    }
    
    // method to set the amount left to go label
    func setAmountLeftToGoLabelText(text: String) {
        amountLeftToDrinkLabel.text = "\(text) mL left"
    }
    
    func setupSlideUpView() {
        slideUpView = Bundle.main.loadNibNamed("SlideUpRoundedView", owner: self, options: nil)!.first as? SlideUpRoundedView
        slideUpView.frame = CGRect(x: 25, y: screenMinY + 300, width: self.view.frame.width - 50, height: 300)
        slideUpView.setupView()
        slideUpView.delegate = self
        self.view.addSubview(slideUpView)
        slideUpView.animateUp(x: 25, width: Int(self.view.frame.width - 50), y: Int(screenMinY - 350))
    }
    
    func removeSlideUpView() {
        slideUpView.animateOut(rect: CGRect(x: 25, y: screenMinY + 300, width: self.view.frame.width - 50, height: 300), completion: { () -> Void in
            self.slideUpView = nil
        })
    }
    
    // MARK: All Actions
    @IBAction func drinkButtonPressed(_ sender: Any) {
        
        NotificationManager.shared.checkPermission()
        if slideUpView != nil {
            removeSlideUpView()
        } else {
            setupSlideUpView()
        }
    }
    
    @IBAction func undoDrinkButtonPressed(_ sender: Any) {
        presenter.undoLastDrink()
        setLabels()
    }
    
    func fillDrinkView(ml: Double) {
        let mililiters = ml / 100
        amountDrankView.fill(to: mililiters as NSNumber)
    }
    
}

extension CurrentAmountDrankViewController: WaterGlassTappedDelegate {
    func waterGlassTapped(mililiters: Int) {
        removeSlideUpView()
        presenter.addDrinkToData(ml: mililiters)
        setLabels()
    }
    
    func closeButtonTapped() {
        removeSlideUpView()
    }
}

