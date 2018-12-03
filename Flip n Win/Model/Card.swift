//
//  Card.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/28/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation
import UIKit.UIImage

class Card : CustomStringConvertible {
    
    // MARK: - Properties
    
    var id:NSUUID = NSUUID.init()
    var shown:Bool = false
    var image:UIImage
    
    // MARK: - Lifecycle
    
    init(image:UIImage) {
        self.image = image
    }
    
    init(card:Card) {
        self.id = card.id.copy() as! NSUUID
        self.shown = card.shown
        self.image = card.image.copy() as! UIImage
    }
    
    // MARK: - Methods
    
    var description: String {
        return "\(id.uuidString)"
    }
    
    func equals(card: Card) -> Bool {
        return card.id.isEqual(id)
    }
}
