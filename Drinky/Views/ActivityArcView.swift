//
//  ActivityArcView.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 30/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import UIKit

class ActivityArcView: UIView {
    
    var endArc:CGFloat = 0.0 {   // in range of 0.0 to 1.0
        didSet{
            setNeedsDisplay()
        }
    }
    
    var arcWidth:CGFloat = 10.0
    var arcColor = UIColor(hue: 0.5389, saturation: 1, brightness: 1, alpha: 1.0)
    var arcBackgroundColor = UIColor.black
    
    var circleLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
        
        //Important constants for circle
        let fullCircle = 2.0 * CGFloat(Double.pi)
        let start:CGFloat = -0.25 * fullCircle
        let end:CGFloat = endArc * fullCircle + start
        
        //find the centerpoint of the rect
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        
        //define the radius by the smallest side of the view
        var radius:CGFloat = 0.0
        if rect.width > rect.height {
            radius = (rect.width - arcWidth) / 2.0
        }else{
            radius = (rect.height - arcWidth) / 2.0
        }
        
        let bezierPath = UIBezierPath()
        
        circleLayer = CAShapeLayer()
        circleLayer?.lineWidth = arcWidth
        circleLayer?.lineCap = .round
        circleLayer?.fillColor = UIColor.clear.cgColor
        circleLayer?.strokeColor = arcColor.cgColor
        
        bezierPath.addArc(withCenter: centerPoint, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        
        circleLayer?.path = bezierPath.cgPath
        
        self.layer.addSublayer(circleLayer!)
    }
}
