//
//  NotificationRangeSlider.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 31/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit

class NotificationRangeSlider: UIControl {
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }

    var minimumValue: CGFloat = 0.0
    var maximumValue: CGFloat = 1.0
    var lowerValue: CGFloat = 0.2
    var upperValue: CGFloat = 0.8
    
    private let trackLayer = CALayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    var lowerThumbImage: UIImage = UIImage(named: "sun-icon")!
    var upperThumbImage: UIImage = UIImage(named: "moon-icon")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = lowerThumbImage
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = upperThumbImage
        addSubview(upperThumbImageView)
        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setting the frames for the controls
    private func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.cornerRadius = 5.0
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                           size: CGSize(width: lowerThumbImage.size.width / 2.0, height: lowerThumbImage.size.height / 2.0))
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                           size: CGSize(width: upperThumbImage.size.width / 2.0, height: upperThumbImage.size.height / 2.0))
    }

    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }

    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - lowerThumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - lowerThumbImage.size.height) / 2.0)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
