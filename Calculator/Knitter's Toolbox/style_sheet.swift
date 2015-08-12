//
//  style_sheet.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/26/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class KnittersToolboxStyles {
    
    
    let controller_font = UIFont(name: "NexaLight", size: 20)!
    let hint_font = UIFont(name: "WrittenonHisHands", size: 20)!
    let handwriting_font = UIFont(name: "WrittenonHisHands", size: 36)!
    let big_handwriting_font = UIFont(name: "WrittenonHisHands", size: 56)!
    let instruction_font = UIFont(name: "NexaLight", size: 20)!
    let title_font = UIFont(name: "NexaLight", size: 20)!
    
    // UIColor

    let top_level_background_color = UIColor(red: 102.0/255.0,
        green: 192.0/255.0,
        blue: 219.0/255.0, alpha: 1.0)
    
//    let plain_text_color = UIColor(red: 142.0 / 255.0,
//        green: 152.0 / 255.0,
//        blue: 161.0 / 255.0,
//        alpha: 1.0)

//    let plain_text_color = UIColor.blackColor()

    let plain_text_color = UIColor(red: 48.0 / 255.0,
        green: 57.0 / 255.0,
        blue: 66.0 / 255.0,
        alpha: 1.0)

    let action_color = UIColor(red: 235.0 / 255.0,
        green: 170.0 / 255.0,
        blue: 28.0 / 255.0,
        alpha: 1.0)
    
    
    let calculator_level_color = UIColor(red: 142.0 / 255.0,
        green: 152.0 / 255.0,
        blue: 161.0 / 255.0,
        alpha: 1.0)
    
    let subsection_level_color = UIColor(red: 193.0 / 255.0,
        green: 202.0 / 255.0,
        blue: 215.0 / 255.0,
        alpha: 1.0)
    
    let icon_background_color = UIColor(red: 204.0 / 255.0,
        green: 213.0 / 255.0,
        blue: 222.0 / 255.0,
        alpha: 1.0)

    let output_background_color = UIColor(red: 249.0 / 255.0,
        green: 249.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1.0)
    
    let disabled_color = UIColor.lightGrayColor()

    let background_color = UIColor.whiteColor()
    


    // Labels
    
    func applyStylesLabelDefaults() {
        let app_proxy = UILabel.appearance()
        app_proxy.font = controller_font
    }

    
    func applyStylesAppTitleBar() {
        let app_proxy = AppTitleBar.appearance()

        app_proxy.font = handwriting_font
        app_proxy.textColor = action_color
        app_proxy.backgroundColor = UIColor.clearColor()
        app_proxy.textAlignment = NSTextAlignment.Center
    }


    func applyStylesCalculatorTitleBar() {
        let app_proxy = CalculatorTitleBar.appearance()
        
        app_proxy.font = title_font
        app_proxy.textColor = plain_text_color
        app_proxy.backgroundColor = top_level_background_color
        app_proxy.textAlignment = NSTextAlignment.Center
    }

    func applyStylesSectionBar() {
        let app_proxy = SectionBar.appearance()
        app_proxy.font = title_font
        app_proxy.textColor = plain_text_color
        app_proxy.backgroundColor = subsection_level_color
        app_proxy.textAlignment = NSTextAlignment.Center
        
        SectionBar.borderColor = calculator_level_color.CGColor
        SectionBar.borderWidth = 1.0
    }
    
    
    func applyStylesHintLabel() {
        let app_proxy = HintLabel.appearance()
        app_proxy.font = hint_font
        app_proxy.textColor = top_level_background_color
        app_proxy.backgroundColor = UIColor.clearColor()
        app_proxy.textAlignment = NSTextAlignment.Left
            }
    


    func applyStylesOutputBox() {
        let app_proxy = OutputBox.appearance()
        app_proxy.font = instruction_font
        app_proxy.textColor = plain_text_color
        app_proxy.backgroundColor = output_background_color
        app_proxy.textAlignment = NSTextAlignment.Left
    }


    
    func applyStylesTabBar() {
        let tabbar_proxy = UITabBar.appearance()
        tabbar_proxy.barTintColor = top_level_background_color
        tabbar_proxy.tintColor = action_color
    }

    
    func applyStylesPickers() {
        
    }
    
    func applyStylesTables() {
        let app_proxy = UITableView.appearance()
        app_proxy.backgroundColor = subsection_level_color
        app_proxy.separatorColor = calculator_level_color

        StitchCalculatorController.headerTextColor = plain_text_color
    }
    
    

    
    func applyStylesSteppers() {
        let app_proxy = UIStepper.appearance()
        app_proxy.tintColor = action_color
        app_proxy.backgroundColor = background_color
    }

    func applyStylesCustomSteppers() {
        KTStepper.buttonColor = action_color
        KTStepper.buttonFont = handwriting_font
        KTStepper.textColor = plain_text_color
        KTStepper.textFont = controller_font
        KTStepper.disabledColor = disabled_color
    }

    
    func applyStylesSegmentedControls() {
        let app_proxy = UISegmentedControl.appearance()
        app_proxy.tintColor = UIColor.clearColor()
        app_proxy.setTitleTextAttributes([
            NSFontAttributeName : handwriting_font,
            NSForegroundColorAttributeName: action_color],
            forState: .Normal)
        app_proxy.setTitleTextAttributes([
            NSFontAttributeName : big_handwriting_font,
//            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
            NSForegroundColorAttributeName: action_color],
            forState: .Selected)
        app_proxy.setTitleTextAttributes([
            NSFontAttributeName : handwriting_font,
            NSForegroundColorAttributeName: disabled_color],
            forState: .Disabled)
    }
    
    func applyStylesHandwrittenButton() {
        HandwrittenButton.buttonColor = action_color
        HandwrittenButton.disabledColor = disabled_color
        HandwrittenButton.buttonFont = hint_font
    }

    
    
    
    func applyStyles() {
        applyStylesLabelDefaults()
        applyStylesAppTitleBar()
        applyStylesCalculatorTitleBar()
        applyStylesSectionBar()
        applyStylesHintLabel()
        applyStylesOutputBox()
        applyStylesTabBar()
        
        applyStylesHandwrittenButton()
        
        applyStylesPickers()
        applyStylesTables()
        applyStylesSteppers()
        applyStylesCustomSteppers()
        applyStylesSegmentedControls()
        
    }
    
    
    //    func style_view(view: UIView) {
    //        view.backgroundColor = background_color
    //    }
    
    
    
    class func make_bulleted_list_style() -> NSMutableParagraphStyle {
        // Format into bulletted list
        let list_paragraph_style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        list_paragraph_style.firstLineHeadIndent = 15
        list_paragraph_style.tailIndent = -15
        list_paragraph_style.headIndent = 30
        list_paragraph_style.paragraphSpacing = 5
        list_paragraph_style.lineSpacing += 3
        return list_paragraph_style
    }
    
    class func style_as_bulleted_list(string_list: [String]) -> NSAttributedString {
        
        var bullet_str: String = join("\n• ", string_list)
        if !bullet_str.isEmpty {
            bullet_str = "• " + bullet_str
        }
        let display_string = NSMutableAttributedString(string: bullet_str)
        let list_paragraph_style = make_bulleted_list_style()
        display_string.addAttribute(NSParagraphStyleAttributeName,
            value: list_paragraph_style,
            range: NSMakeRange(0, display_string.length))
        return display_string
    }
    
}