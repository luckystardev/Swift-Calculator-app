//
//  TitleBarView.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 1/27/15.
//  Copyright (c) 2015 Amy Herzog Designs. All rights reserved.
//


import Foundation
import UIKit
import CoreGraphics

private var _borderColor : CGColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(),
    [200.0 / 255.0, 223.0 / 255.0, 220.0 / 255.0, 1.0])!
private var _borderWidth : CGFloat = 0.0


class  AppTitleBar: UILabel {
    
    class var borderColor: CGColor
        {
        get { return _borderColor }
        set { _borderColor = newValue }
    }
    
    class var borderWidth: CGFloat
        {
        get { return _borderWidth }
        set { _borderWidth = newValue }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.style()
    }
    
    override init(){
        super.init()
        self.style()
    }
    
    
    func style() {
        self.layer.borderColor = AppTitleBar.borderColor
        self.layer.borderWidth = AppTitleBar.borderWidth
    }
    
}

