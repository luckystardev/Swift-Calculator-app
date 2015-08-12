//
//  ButtonpacerController.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/7/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import UIKit


let initial_total_stitches: Int = 100
let initial_num_buttons: Int = 5
let initial_stitches_per_buttonhole: Int = 2
let max_stitches: Int = 1000
let min_buttons: Int = 1
let max_buttons: Int = 100
let min_stitches_per_hole: Int = 1
let max_stitches_per_hole: Int = 5




class ButtonBandSpacerController: UIViewController  {

    @IBOutlet var instructionTextLabel: UILabel!
        
    @IBOutlet var numStitchesStepper: KTStepper!
    @IBOutlet var numButtonsStepper: KTStepper!
    @IBOutlet var stitchesPerHoleControl: UISegmentedControl!
    
    // These two arrays are a nice, central place to hold the values
    // we want to show in the segmented control
    
    var stitchPerHoleOptions : [Int]?
    var stitchPerHoleSelectable: [Bool]?
    
    
    var currentButtonBand = ButtonBand(total_stitches : initial_total_stitches,
        number_of_buttons: initial_num_buttons,
        stitches_per_buttonhole: initial_stitches_per_buttonhole)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        view = self.view
//        let styler = KnittersToolboxStyles()
//        styler.style_view(view)

        numStitchesStepper.addTarget(self,
            action: "numStitchesStepperChanged",
            forControlEvents: UIControlEvents.ValueChanged)
        numButtonsStepper.addTarget(self,
            action: "numButtonsChanged",
            forControlEvents: UIControlEvents.ValueChanged)
        refreshUI()
    }


    
    func refreshInstructionText() {
        let initial_text = currentButtonBand!.initial_instruction_text()
        let middle_text = currentButtonBand!.middle_instruction_text()
        let final_text = currentButtonBand!.final_instruction_text()
        
        
        let display_string =
            KnittersToolboxStyles.style_as_bulleted_list([initial_text,
                middle_text,
                final_text])
                
        instructionTextLabel.attributedText = display_string
    }
    
    
    func refreshNumStitches() {
        let total_stitches = currentButtonBand!.total_stitches
        numStitchesStepper.value = total_stitches
        numStitchesStepper.maximumValue = max_stitches
        numStitchesStepper.minimumValue = currentButtonBand!.min_stitches
        let new_label_text = makeLabelText(total_stitches, "stitch", "stitches")
        numStitchesStepper.text = new_label_text
        
    }


    
    func refreshNumButtons() {
        
        let numButtons = currentButtonBand!.number_of_buttons
        
        // Validate the input
        let curr_max_buttons = min(max_buttons, currentButtonBand!.max_buttonholes)
        assert(min_buttons <= curr_max_buttons)
        assert(numButtons <= curr_max_buttons)
        assert(min_buttons <= numButtons)

        numButtonsStepper.value = numButtons
        numButtonsStepper.maximumValue = curr_max_buttons
        numButtonsStepper.minimumValue = min_buttons
        let new_label_text = makeLabelText(numButtons, "button", "buttons")
        numButtonsStepper.text = new_label_text

    }

    
    
    func refreshStitchesPerButtonhole() {
        
        // Disable those segments which are not possible
        let curr_max_sts_per_hole = currentButtonBand!.max_stitches_per_hole
        for sts in 1...stitchesPerHoleControl.numberOfSegments {
            var index = sts - 1
            var enabled = (sts <= curr_max_sts_per_hole)
            stitchesPerHoleControl.setEnabled(enabled, forSegmentAtIndex: index)
        }
        let curr_index = currentButtonBand!.stitches_per_buttonhole - 1
        stitchesPerHoleControl.selectedSegmentIndex = curr_index
    }

    
    func refreshUI() {
        refreshInstructionText()
        refreshNumButtons()
        refreshNumStitches()
        refreshStitchesPerButtonhole()
    }
    

    //
    // 'outgoing' methods: those which feed information to pickers and steppers
    //
    
    
    // Stepper
    @IBAction func numStitchesStepperChanged() {
        let current_number_stitches: Int = numStitchesStepper.value
        let current_stitches_per_buttonhole: Int = currentButtonBand!.stitches_per_buttonhole
        let current_number_buttons: Int = currentButtonBand!.number_of_buttons
        
        currentButtonBand = ButtonBand(total_stitches: current_number_stitches,
            number_of_buttons: current_number_buttons,
            stitches_per_buttonhole: current_stitches_per_buttonhole)
        
        refreshUI()
    }

    
    
    @IBAction func numButtonsChanged() {
        let current_number_buttons: Int = numButtonsStepper.value
        let current_stitches_per_buttonhole: Int = currentButtonBand!.stitches_per_buttonhole
        let current_number_stitches: Int = currentButtonBand!.total_stitches
        
        currentButtonBand = ButtonBand(total_stitches: current_number_stitches,
            number_of_buttons: current_number_buttons,
            stitches_per_buttonhole: current_stitches_per_buttonhole)
        
        refreshUI()

    }
    

    @IBAction func stitchesPerHoleChanged(sender: UISegmentedControl) {
        let current_number_buttons = currentButtonBand!.number_of_buttons
        let current_number_stitches = currentButtonBand!.total_stitches
        
        let current_stitches_per_buttonhole = sender.selectedSegmentIndex + 1
        
        currentButtonBand = ButtonBand(total_stitches: current_number_stitches,
            number_of_buttons: current_number_buttons,
            stitches_per_buttonhole: current_stitches_per_buttonhole)
        
        refreshUI()
        
    
    }
    
}

