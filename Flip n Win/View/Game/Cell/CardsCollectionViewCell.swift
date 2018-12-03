//
//  CardsCollectionViewCell.swift
//  Flip'n Win
//
//  Created by Mathieu Lamvohee on 11/26/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    static let reuseId = "cardCell"
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    var card: Card? {
        didSet {
            guard let card = card else { return }
            frontImageView.image = card.image
        }
    }
    
    private(set) var shown: Bool = false
    
    // MARK: - Methods
    
    func showCard(show: Bool, animted: Bool) {
        frontImageView.isHidden = false
        backImageView.isHidden = false
        shown = show
        
        if animted {
            if show {
                let transitionOption = UIView.AnimationOptions.transitionFlipFromLeft
                UIView.transition(with: self, duration: 0.5, options: transitionOption, animations: {
                    self.backImageView.isHidden = true
                    self.frontImageView.isHidden = false
                }) { (finished) in}
            } else {
                let transitionOption = UIView.AnimationOptions.transitionFlipFromRight
                
                UIView.transition(with: self, duration: 0.5, options: transitionOption, animations: {
                    self.backImageView.isHidden = false
                    self.frontImageView.isHidden = true
                }) { (finished) in}
            }
        } else {
            if show {
                bringSubviewToFront(frontImageView)
                backImageView.isHidden = true
            } else {
                bringSubviewToFront(backImageView)
                frontImageView.isHidden = true
            }
        }
    }
}
