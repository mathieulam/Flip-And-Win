//
//  Launcher.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/30/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class ConfettiLauncher: CAEmitterLayer {
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    func setup(frame: CGRect)  {
        emitterPosition = CGPoint(x: frame.width / 2, y: -10)
        emitterShape = CAEmitterLayerEmitterShape.line
        emitterSize = CGSize(width: frame.size.width, height: 2)
    }
    
    func launchConfettis()  {
        emitterCells = createConfettiEmitterCell()
    }
    
    func createConfettiEmitterCell() -> [Confettis] {
        var confettis = [Confettis]()
        for _ in (0...30) {
            confettis.append(Confettis())
        }
        return confettis
    }

}
