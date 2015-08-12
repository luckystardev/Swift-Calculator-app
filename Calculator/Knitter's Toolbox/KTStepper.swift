//
//  KTStepper.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 1/29/15.
//  Copyright (c) 2015 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit

private var _button_font : UIFont = UIFont(name: "Chalkduster", size: 20)!
private var _button_color : UIColor = UIColor.blueColor()

private var _text_font : UIFont =  UIFont(name: "Chalkduster", size: 20)!
private var _text_color : UIColor = UIColor.blueColor()

private var _disabled_color : UIColor = UIColor.grayColor()

class KTStepper : UIControl {
    // Implements the a specialized stepper for Knitter's Toolbox:
    // one with a minus button on the left, a plus button on the right, 
    // and customizable text in between.
    
    // sub-views/controls
    let plus_button = UIButton.buttonWithType(.Custom) as UIButton
    let minus_button = UIButton.buttonWithType(.Custom) as UIButton
    let text_label = UILabel()
    
    
    // Timer and counter to use for long taps (i.e., they hold down the 
    // plus or minus button). These will let us repeat the addition/subtraction
    // and even speed up after a certain amount of time.
    var hold_timer: NSTimer?
    var hold_count: Int = 0
    let initial_delay : NSTimeInterval = 0.3
    let short_delay : NSTimeInterval = 0.05
    let short_delay_threshold = 2
    let really_short_delay : NSTimeInterval = 0.01
    let really_short_delay_threshold = 22
    
    //current value
    var value: Int = 0 {
        didSet {
            if value > self.maximumValue {
                value = self.maximumValue
            }
            if value < self.minimumValue {
                value = self.minimumValue
            }
        }
    }

    // increment/decrement value
    var stepValue: Int = 1
    
    // minimum value
    var minimumValue: Int = 0 {
        didSet {
            if self.maximumValue < minimumValue {
                self.maximumValue = minimumValue
            }
            if self.value < minimumValue {
                self.value = minimumValue
            }
        }
    }
    
    // maximum value
    var maximumValue: Int = 100 {
        didSet {
            if self.minimumValue > maximumValue {
                self.minimumValue = maximumValue
            }
            if self.value >  maximumValue {
                self.value = maximumValue
            }
        }
    }
    

    // text to display between the +/- buttons
    var text: String = "placeholder text" {
        didSet {
            refreshUI()
        }
    }
    
    var intrinsic_width : CGFloat {
        get {
            return [plus_button.intrinsicContentSize().width,
                    minus_button.intrinsicContentSize().width,
                    text_label.intrinsicContentSize().width].reduce(0,+)
        }
    }
    
    var intrinsic_height : CGFloat {
        get {
            return max(plus_button.intrinsicContentSize().height,
                    minus_button.intrinsicContentSize().height,
                    text_label.intrinsicContentSize().height)
        }
    }

    
    
    
    
    class var buttonColor: UIColor
        {
        get { return _button_color }
        set {
            _button_color = newValue
        }
    }
    
    class var buttonFont: UIFont
        {
        get { return _button_font }
        set {
            _button_font = newValue
        }
    }
    
    class var textColor: UIColor
        {
        get { return _text_color }
        set {
            _text_color = newValue
        }
    }
    
    class var textFont: UIFont
        {
        get { return _text_font }
        set {
            _text_font = newValue
        }
    }
    
    class var disabledColor: UIColor
        {
        get { return _disabled_color }
        set {
            _disabled_color = newValue
        }
    }
    

    
    func refreshUI() {
        text_label.text = text
        minus_button.enabled = (value - minimumValue >= stepValue)
        plus_button.enabled = (maximumValue - value >= stepValue)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init() {
        super.init()
        initialize()
    }
    
    func initialize() {
        // a single place to hold all initialization code

        self.multipleTouchEnabled = false
        self.backgroundColor = UIColor.clearColor()

        
        let button_title_attrs =
            [NSForegroundColorAttributeName: KTStepper.buttonColor,
                NSFontAttributeName: KTStepper.buttonFont]
        let button_title_disabled_attrs =
        [NSForegroundColorAttributeName: KTStepper.disabledColor,
            NSFontAttributeName: KTStepper.buttonFont]
        
        
        //  minus button is on left
        minus_button.addTarget(self,
            action: "did_press_minus_button",
            forControlEvents: UIControlEvents.TouchUpInside)
        minus_button.addTarget(self,
            action: "did_begin_minus_long_tap",
            forControlEvents: UIControlEvents.TouchDown |
                UIControlEvents.TouchDragEnter)
        minus_button.addTarget(self,
            action: "did_end_long_tap",
            forControlEvents: UIControlEvents.TouchUpInside |
                UIControlEvents.TouchUpOutside |
                UIControlEvents.TouchCancel |
                UIControlEvents.TouchDragExit)
        minus_button.setAttributedTitle(
            NSAttributedString(string: "-",
                attributes: button_title_attrs),
            forState: UIControlState.Normal)
        minus_button.setAttributedTitle(
            NSAttributedString(string: "-",
                attributes: button_title_disabled_attrs),
            forState: UIControlState.Disabled)
        
        
        addSubview(minus_button)

        //  plus button is on right
        plus_button.addTarget(self,
            action: "did_press_plus_button",
            forControlEvents: UIControlEvents.TouchUpInside)
        plus_button.addTarget(self,
            action: "did_begin_plus_long_tap",
            forControlEvents: UIControlEvents.TouchDown |
                UIControlEvents.TouchDragEnter)
        plus_button.addTarget(self,
            action: "did_end_long_tap",
            forControlEvents: UIControlEvents.TouchUpInside |
                UIControlEvents.TouchUpOutside |
                UIControlEvents.TouchCancel |
                UIControlEvents.TouchDragExit)
        plus_button.setAttributedTitle(
            NSAttributedString(string: "+",
                attributes: button_title_attrs),
            forState: UIControlState.Normal)
        plus_button.setAttributedTitle(
            NSAttributedString(string: "+",
                attributes: button_title_disabled_attrs),
            forState: UIControlState.Disabled)
        
        
        addSubview(plus_button)
        

        // The text label
        
        text_label.textAlignment = .Center
        text_label.text = text
//        text_label.autoresizingMask = UIViewAutoresizing.None // reset bitmask
//        text_label.autoresizingMask = UIViewAutoresizing.FlexibleWidth |
//            UIViewAutoresizing.FlexibleTopMargin |
//            UIViewAutoresizing.FlexibleBottomMargin

        
        addSubview(text_label)

        setupLayout()
        refreshUI()
    }
    
    
    func setupLayout() {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        var constraintsArray = Array<NSObject>()
        
        
        // text field is horozontally centered
        text_label.setTranslatesAutoresizingMaskIntoConstraints(false)
        constraintsArray.append(
            NSLayoutConstraint(item: text_label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0)
        )
        constraintsArray.append(
            NSLayoutConstraint(item: text_label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 0)
        )
        constraintsArray.append(
            NSLayoutConstraint(item: text_label,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Width,
                multiplier: 0.6,
                constant: 0)
        )


        // minus button is on left, and horozontally centered
        minus_button.setTranslatesAutoresizingMaskIntoConstraints(false)
        constraintsArray.append(
            NSLayoutConstraint(item: minus_button,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: text_label,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1.0,
                constant: 0)
        )
        constraintsArray.append(
            NSLayoutConstraint(item: minus_button,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: -10.0)
        )

        // plus button is on right, and horozontally centered
        plus_button.setTranslatesAutoresizingMaskIntoConstraints(false)
        constraintsArray.append(
            NSLayoutConstraint(item: plus_button,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: text_label,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1.0,
                constant: 0)
        )
        constraintsArray.append(
            NSLayoutConstraint(item: plus_button,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: -5.0)
        )

        
        self.addConstraints(constraintsArray)
        
    }
    
    
//    override func intrinsicContentSize() -> CGSize {
//        return CGSizeMake(NSViewNoInstrinsicMetric, NSViewNoInstrinsicMetric)
//    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    
    
    
    
    
    
    
    func did_press_plus_button() {
        
        println("did_press_plus_button")
        value += stepValue
        // Everything else handled in the property observer
        sendActionsForControlEvents(.ValueChanged)

    }
    

    func did_press_minus_button() {
        println("did_press_minus_button")
        value -= stepValue
        // Everything else handled in the property observer
        sendActionsForControlEvents(.ValueChanged)
    }

    
    
    
    func did_begin_plus_long_tap() {
        println("did_begin_plus_long_tap")
        hold_timer = NSTimer.scheduledTimerWithTimeInterval(initial_delay,
            target: self,
            selector: "held_plus_button_loop",
            userInfo: nil,
            repeats: false)
    }
    
    func held_plus_button_loop() {
        println("held_plus_button_loop")
        did_press_plus_button()
        hold_count += 1
        var next_delay: NSTimeInterval
        if hold_count <= short_delay_threshold {
            next_delay = initial_delay
        } else if hold_count < really_short_delay_threshold {
            next_delay = short_delay
        } else {
            next_delay = really_short_delay
        }
        hold_timer = NSTimer.scheduledTimerWithTimeInterval(next_delay,
            target: self,
            selector: "held_plus_button_loop",
            userInfo: nil,
            repeats: false)
    }

    
    func did_begin_minus_long_tap() {
        println("did_begin_minus_long_tap")
        hold_timer = NSTimer.scheduledTimerWithTimeInterval(initial_delay,
            target: self,
            selector: "held_minus_button_loop",
            userInfo: nil,
            repeats: false)
        
    }

    func held_minus_button_loop() {
        println("held_minus_button_loop")
        did_press_minus_button()
        hold_count += 1
        var next_delay: NSTimeInterval
        if hold_count <= short_delay_threshold {
            next_delay = initial_delay
        } else if hold_count < really_short_delay_threshold {
            next_delay = short_delay
        } else {
            next_delay = really_short_delay
        }
        hold_timer = NSTimer.scheduledTimerWithTimeInterval(next_delay,
            target: self,
            selector: "held_minus_button_loop",
            userInfo: nil,
            repeats: false)
    }

    
    func did_end_long_tap() {
        println("did_end_long_tap")
        hold_timer!.invalidate()
        hold_timer = nil
        hold_count = 0
    }
}
