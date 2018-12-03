//
//  Confettis.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/30/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit
import QuartzCore

class Confettis: CAEmitterCell {
    var images = [#imageLiteral(resourceName: "confetti.png")]
    var intensity: Float! = 0.5
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        contents = images[Int(arc4random_uniform(UInt32(images.count)))].cgImage
        birthRate = 6.0 * intensity
        lifetime = 14.0 * intensity
        lifetimeRange = 0
        color = UIColor(red: floatAleatoire(), green: floatAleatoire(), blue: floatAleatoire(), alpha: 1).cgColor
        velocity = CGFloat(350.0 * intensity)
        velocityRange = CGFloat(80.0 * intensity)
        emissionLongitude = CGFloat(Double.pi)
        emissionRange = CGFloat(Double.pi)
        spin = CGFloat(3.5 * intensity)
        spinRange = CGFloat(4.0 * intensity)
        scaleRange = CGFloat(intensity)
        scaleSpeed = CGFloat(-0.1 * intensity)
    }
    
    func floatAleatoire() -> CGFloat {
        return CGFloat(arc4random_uniform(255)) / 255
    }
    
}
