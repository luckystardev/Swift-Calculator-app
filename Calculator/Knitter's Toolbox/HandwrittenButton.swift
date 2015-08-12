//
//  HandwrittenButton.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 1/31/15.
//  Copyright (c) 2015 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit

private var _button_font : UIFont = UIFont(name: "Chalkduster", size: 20)!
private var _button_color : UIColor = UIColor.blueColor()
private var _disabled_color : UIColor = UIColor.blueColor()


class HandwrittenButton : UIButton {

    
    class var buttonColor: UIColor
        {
        get { return _button_color }
        set {
            _button_color = newValue
        }
    }
    
    class var disabledColor: UIColor
        {
        get { return _disabled_color }
        set {
            _disabled_color = newValue
        }
    }
    
    class var buttonFont: UIFont
        {
        get { return _button_font }
        set {
            _button_font = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        apply_styles()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        apply_styles()
    }
    
    
    
    func apply_styles() {
        self.titleLabel!.font = HandwrittenButton.buttonFont
        self.setTitleColor(HandwrittenButton.buttonColor, forState: UIControlState.Normal)
        self.setTitleColor(HandwrittenButton.disabledColor, forState: UIControlState.Disabled)
    }
    
    override func drawRect(rect: CGRect) {
        apply_styles()
        super.drawRect(rect)
    }
    

}