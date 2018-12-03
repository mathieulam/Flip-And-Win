//
//  CustomButton.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/28/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation
import UIKit

class CustomPickerButton: UIButton {
    
    var pickerView = UIView()
    var toolBarView = UIView()
    
    override var inputView: UIView {
        
        get {
            return self.pickerView
        }
        set {
            self.pickerView = newValue
            self.becomeFirstResponder()
        }
        
    }
    
    override var inputAccessoryView: UIView {
        get {
            return self.toolBarView
        }
        set {
            self.toolBarView = newValue
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}
