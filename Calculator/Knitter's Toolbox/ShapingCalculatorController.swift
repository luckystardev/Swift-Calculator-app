//
//  SecondViewController.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/7/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import UIKit


let initial_starting_stitches = 100
let initial_ending_stitches = 120
let initial_total_rows = 20
let initial_stitches_per_row = 2

class ShapingCalculatorViewController: UIViewController {

    
    @IBOutlet var instructionTextLabel: UILabel!

    @IBOutlet var startingStitchesStepper: KTStepper!
    @IBOutlet var endingStitchesStepper: KTStepper!
    @IBOutlet var totalRowsStepper: KTStepper!
    @IBOutlet var shapingStartButton: HandwrittenButton!
    
    @IBOutlet var stitchesPerRowController: UISegmentedControl!
    
    @IBOutlet var increaseDecreaseBar: SectionBar!
    
    let min_stitches_per_row = 1
    let max_stitches_per_row = 4
    
    // Smallest legal value for starting stitches
    let min_starting_stitches = 1
    
    // Largest legal value for starting stitches 
    let max_starting_stitches = 1000
    
    // Smallest legal value for ending stitches
    let min_ending_stitches = 1
    
    // Largest legal value for ending stitches
    let max_ending_stitches = 1000
    
    // Smallest legal value for total rows
    let min_total_rows = 1
    
    // Largest legal value for total_rows
    let max_total_rows = 1000
    
    // ShapingResult when user wants to start/end with shaping rows
    var bookended_shaping_result = ShapingResult(starting_stitches: initial_starting_stitches,
        ending_stitches: initial_ending_stitches,
        total_rows: initial_total_rows,
        shaping_row_delta: initial_stitches_per_row,
        start_and_end_with_shaping_row: true)
    
    // ShapingResult for when the user does not need us to start/end with
    // shaping rows
    var non_bookended_shaping_result = ShapingResult(starting_stitches: initial_starting_stitches,
        ending_stitches: initial_ending_stitches,
        total_rows: initial_total_rows,
        shaping_row_delta: initial_stitches_per_row,
        start_and_end_with_shaping_row: true)

    // Does the user want us to start & end with shaping row?
    var user_wants_bookended: Bool = true
    
    
    var current_shaping_result: ShapingResult? {
        get {
            return (user_wants_bookended ? bookended_shaping_result : non_bookended_shaping_result)
        }
    }
    
    
    func set_shaping_results(starting_stitches: Int,
        ending_stitches: Int,
        total_rows: Int,
        shaping_row_delta: Int) {
            non_bookended_shaping_result =
                ShapingResult(starting_stitches: starting_stitches,
                    ending_stitches: ending_stitches,
                    total_rows: total_rows,
                    shaping_row_delta: shaping_row_delta,
                    start_and_end_with_shaping_row: false)
            bookended_shaping_result =
                ShapingResult(starting_stitches: starting_stitches,
                    ending_stitches: ending_stitches,
                    total_rows: total_rows,
                    shaping_row_delta: shaping_row_delta,
                    start_and_end_with_shaping_row: true)
    }
    
    //
    // UI-refreshing methods
    //
    
    func refreshInstructionLabel() {
        
        let instruction_strings = current_shaping_result!.make_instruction_texts()
        
        let display_string =
            KnittersToolboxStyles.style_as_bulleted_list(instruction_strings)
        instructionTextLabel.attributedText = display_string
    }
    
    func refreshStartingStitchesUI() {

        let stitch_delta = current_shaping_result!.shaping_row_delta
        startingStitchesStepper.stepValue = stitch_delta
        
        // Note: set endpoints *first*, since UIStepper will truncate
        // value to be within them.
        var new_max = current_shaping_result!.max_starting_stitches
        if new_max > max_starting_stitches {
            new_max = max_starting_stitches
        }
        startingStitchesStepper.maximumValue = new_max
        
        
        var new_min = current_shaping_result!.min_starting_stitches
        if new_min < min_starting_stitches {
            new_min = min_starting_stitches
        }
        startingStitchesStepper.minimumValue = new_min
        
        let starting_stitches = current_shaping_result!.starting_stitches
        startingStitchesStepper.value = starting_stitches


        
        let new_label_text = makeLabelText(starting_stitches,
                                            "st",
                                            "sts")
        startingStitchesStepper.text = new_label_text

        }
    
    func refreshEndingStitchesUI(){
        let stitch_delta = current_shaping_result!.shaping_row_delta
        endingStitchesStepper.stepValue = stitch_delta

        // Note: set endpoints *first*, since UIStepper will truncate
        // value to be within them.
        var new_max = current_shaping_result!.max_ending_stitches
        if new_max > max_ending_stitches {
            new_max = max_ending_stitches
        }
        endingStitchesStepper.maximumValue = new_max
        
        
        var new_min = current_shaping_result!.min_ending_stitches
        if new_min < min_ending_stitches {
            new_min = min_ending_stitches
        }
        endingStitchesStepper.minimumValue = new_min
        
        let ending_stitches = current_shaping_result!.ending_stitches
        endingStitchesStepper.value = ending_stitches
        

        
        let new_label_text = makeLabelText(ending_stitches,
            "st",
            "sts")
        endingStitchesStepper.text = new_label_text
    }
    
    func refreshTotalRowsAndControl() {
        
        var controller_index : Int
        var is_compatible: Bool
        for index in min_stitches_per_row...max_stitches_per_row {
            controller_index = index - 1
            is_compatible = current_shaping_result!.is_compatible_stitch_delta(index)
            stitchesPerRowController.setEnabled(is_compatible, forSegmentAtIndex: controller_index)
        }
        let curr_index = current_shaping_result!.shaping_row_delta - 1
        stitchesPerRowController.selectedSegmentIndex = curr_index
        
        var new_text : String
        if current_shaping_result!.starting_stitches > current_shaping_result!.ending_stitches {
             new_text = "decreases per row"
        } else {
            new_text = "increases per row"
        }
        if new_text != increaseDecreaseBar.text {
            
            let animation = CATransition()
            animation.type = kCATransitionFade
            increaseDecreaseBar.layer.addAnimation(animation,
                forKey: "changeTextTransition")
            
            // Change the text
            increaseDecreaseBar.text = new_text
        }
        
        let total_rows = current_shaping_result!.total_rows
        totalRowsStepper.value = total_rows
        totalRowsStepper.maximumValue = max_total_rows
        totalRowsStepper.minimumValue = current_shaping_result!.min_total_rows


        let new_label_text = makeLabelText(total_rows,
            "",
            "")
        totalRowsStepper.text = new_label_text
    }
    
    func refreshBookendButton() {
        let button_text : String = "start & end with shaping row"
        var attributes = [NSObject : AnyObject]()
        var enabled : Bool = true
        
        
        if !user_wants_bookended {
            attributes[NSStrikethroughStyleAttributeName] = 1
        }
        
        if bookended_shaping_result == non_bookended_shaping_result {
            enabled = false
            attributes[NSForegroundColorAttributeName] = HandwrittenButton.disabledColor
        } else {
            attributes[NSForegroundColorAttributeName] = HandwrittenButton.buttonColor
            enabled = true
        }
        
        let attr_string =
            NSAttributedString(string: button_text, attributes: attributes)
        shapingStartButton.enabled = enabled
        shapingStartButton.setAttributedTitle(attr_string, forState: .Normal)
    }
    
    func refreshUI() {
        refreshInstructionLabel()
        refreshStartingStitchesUI()
        refreshEndingStitchesUI()
        refreshTotalRowsAndControl()
        refreshBookendButton()
    }


    //
    // 'outgoing' methods-- those which feed information to pickers and
    // steppers
    //
    
    
    //
    // 'incoming' methods-- those which receive information from pickers
    // and steppers
    //
    
    // steppers
    
    @IBAction func numStartingStitchesChanged() {
        
        let ending_stitches = current_shaping_result!.ending_stitches
        let total_rows = current_shaping_result!.total_rows

        // see if new value is equal to the ending_stitches value. If not
        // adjust it.
        var new_start_stitches = startingStitchesStepper.value
        if new_start_stitches == ending_stitches {
            // The new start_stitches value is the same as the ending_stitches
            // value. We are going to adjust it so that it is off by one.
            // Which direction? The one *other* than the old one, so the user
            // realizes that it is possible to change in that way.
            
            if current_shaping_result!.shaping_increases {
                new_start_stitches = ending_stitches + current_shaping_result!.shaping_row_delta
            } else {
                new_start_stitches = ending_stitches - current_shaping_result!.shaping_row_delta
            }
            
        }
        
        
        // Okay, now we need to determine the new stitch_delta. Let's try
        // to use the old value. If that doesnt' work, we'll default to one.
        let stitch_delta = current_shaping_result!.shaping_row_delta

        set_shaping_results(new_start_stitches,
                ending_stitches: ending_stitches,
                total_rows: total_rows,
                shaping_row_delta: stitch_delta)
        if current_shaping_result == nil {
            set_shaping_results(new_start_stitches,
                    ending_stitches: ending_stitches,
                    total_rows: total_rows,
                    shaping_row_delta: 1)
        }
        refreshUI()
    }

    @IBAction func numEndingStitchesChanged() {
        let start_stitches = current_shaping_result!.starting_stitches
        let stitch_delta = current_shaping_result!.shaping_row_delta
        let total_rows = current_shaping_result!.total_rows
        // see if new value is equal to the starting_stitches value. If not
        // adjust it.
        var new_end_stitches = endingStitchesStepper.value
        if new_end_stitches == start_stitches {
            // The new end_stitches value is the same as the starting_stitches
            // value. We are going to adjust it so that it is off by one.
            // Which direction? The one *other* than the old one, so the user
            // realizes that it is possible to change in that way.
            
            if current_shaping_result!.shaping_increases {
                new_end_stitches = start_stitches - current_shaping_result!.shaping_row_delta
            } else {
                new_end_stitches = start_stitches + current_shaping_result!.shaping_row_delta
            }
        }
        
        // Okay, now we need to determine the new stitch_delta. Let's try
        // to use the old value. If that doesnt' work, we'll default to one.
        set_shaping_results(start_stitches,
                ending_stitches: new_end_stitches,
                total_rows: total_rows,
                shaping_row_delta: stitch_delta)
        if current_shaping_result == nil {
            set_shaping_results(start_stitches,
                    ending_stitches: new_end_stitches,
                    total_rows: total_rows,
                    shaping_row_delta: 1)
        }
        refreshUI()
    }

    @IBAction func numTotalRowsChanged() {
        let start_stitches = current_shaping_result!.starting_stitches
        let ending_stitches = current_shaping_result!.ending_stitches
        let stitch_delta = current_shaping_result!.shaping_row_delta
        let total_rows = totalRowsStepper.value
        set_shaping_results(start_stitches,
                ending_stitches: ending_stitches,
                total_rows: total_rows,
                shaping_row_delta: stitch_delta)
        
        refreshUI()
    }

    
    
    @IBAction func stitchesPerRowChanged(sender: UISegmentedControl) {

        let new_stitches_per_row = sender.selectedSegmentIndex + 1
        let start_stitches = current_shaping_result!.starting_stitches
        let ending_stitches = current_shaping_result!.ending_stitches
        let stitch_delta = new_stitches_per_row
        let total_rows = current_shaping_result!.total_rows
        set_shaping_results(start_stitches,
                ending_stitches: ending_stitches,
                total_rows: total_rows,
                shaping_row_delta: stitch_delta)
        
        refreshUI()
    
    }

    @IBAction func startButtonPressed() {
        user_wants_bookended = !user_wants_bookended
        refreshUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        view = self.view
//        let styler = KnittersToolboxStyles()
//        styler.style_view(view)
        startingStitchesStepper.addTarget(self,
            action: "numStartingStitchesChanged",
            forControlEvents: UIControlEvents.ValueChanged)
        endingStitchesStepper.addTarget(self,
            action: "numEndingStitchesChanged",
            forControlEvents: UIControlEvents.ValueChanged)
        totalRowsStepper.addTarget(self,
            action: "numTotalRowsChanged",
            forControlEvents: UIControlEvents.ValueChanged)

        refreshUI()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

