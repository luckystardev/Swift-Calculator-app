//
//  button_band.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/7/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation


class ButtonBand {
    
    // 
    // Stored properties.
    
    // Stitches before first hole. Must be positive
    let initial_stitches: Int

    // Stitches after last hole. Must be positive.
    let final_stitches: Int

    // Stitches consumed in each buttonhole. Must be positive.
    let stitches_per_buttonhole: Int
    
    // Stitches between consecutive buttonholes, not including any in the
    // buttonholes. Will be nil if fewer than two buttonholes.
    let stitches_between_buttonholes: Int?
    
    // Must be positive.
    let number_of_buttons : Int
    
    
    //
    // Computed properties (read-only
    //
    
    var total_stitches: Int {
        get {
            var return_me = initial_stitches
            return_me += final_stitches
            return_me += (stitches_per_buttonhole * number_of_buttons)
            if stitches_between_buttonholes != nil {
                return_me += stitches_between_buttonholes! * (number_of_buttons - 1)
            }
            return return_me
        }
    }
    
    // Fewest stitches that lead to legal results, assuming that the
    // stitches-per-buttonhole and num-buttons remain constant
    var min_stitches: Int {
        return (number_of_buttons * (stitches_per_buttonhole + 1)) + 1
    }
    
    // Largest number of buttonholes that lead to legal results, assuming
    // that the number of stitches and stitches-per-buttonhole remain constant
    var max_buttonholes: Int {
        return (total_stitches - 1) / (stitches_per_buttonhole + 1)
    }
    
    // Largest number of stitches-per-hole that lead to legal results,
    // assuming that the num-stitches and num-buttons remain constant
    var max_stitches_per_hole: Int {
        return ((total_stitches - 1) / number_of_buttons) - 1
    }
    
    init?(total_stitches: Int,
        number_of_buttons: Int,
        stitches_per_buttonhole: Int){
            
            
            let spacing_result = SpacingResult(total_units: total_stitches,
                number_of_events: number_of_buttons,
                units_per_event: stitches_per_buttonhole)

            if (number_of_buttons <= 0)
                || (stitches_per_buttonhole <= 0)
                || (spacing_result == nil) {
                // A bug in swift requires that we fully initialize the instance
                // before the initializer can fail:
                // http://stackoverflow.com/questions/26495586/best-practice-to-implement-a-failable-initializer-in-swift
                // Okay:
                
                initial_stitches = 0
                final_stitches  = 0
                self.stitches_per_buttonhole = 0
                stitches_between_buttonholes = 0
                self.number_of_buttons = 0
                
                return nil
            } else {
                self.stitches_per_buttonhole = spacing_result!.units_per_event
                self.number_of_buttons = spacing_result!.number_of_events
                
                
                var extra_stitches = spacing_result!.extra_units
                
                if spacing_result!.units_between_events == nil {
                    stitches_between_buttonholes = nil
                } else {
                    let number_interior_buckets = spacing_result!.number_of_events - 1
                    
                    if (extra_stitches >= number_interior_buckets) {
                        stitches_between_buttonholes = spacing_result!.units_between_events! + 1
                        extra_stitches -= number_interior_buckets
                    } else {
                        stitches_between_buttonholes = spacing_result!.units_between_events
                    }
                }
                

                var stitches_to_give = extra_stitches / 2
                initial_stitches = spacing_result!.units_before_first_event + stitches_to_give
                extra_stitches -= stitches_to_give
                final_stitches = spacing_result!.units_after_last_event + extra_stitches
                
            }
            
            // Validate final values, return nil if anything is wrong
            
            if (initial_stitches <= 0)
                || (final_stitches <= 0)
                || (stitches_per_buttonhole <= 0)
                || ( (stitches_between_buttonholes != nil) && (stitches_between_buttonholes! <= 0))
                || (number_of_buttons <= 0) {
                    return nil
            }
    }
    
    func initial_instruction_text() -> String {
        
        if initial_stitches > 1 {
            return "work \(initial_stitches) sts, "
        } else {
            return "work \(initial_stitches) st, "
        }
        
    }
    
    func middle_instruction_text() -> String {
        
        var per_button_text = ""
        var inner_text = ""
        
        if stitches_per_buttonhole > 1 {
            per_button_text += "work buttonhole over \(stitches_per_buttonhole) sts"
        } else {
            per_button_text += "work buttonhole over \(stitches_per_buttonhole) st"
        }

        if stitches_between_buttonholes == nil {
            
            inner_text = per_button_text
            
        } else {
            
            if stitches_between_buttonholes > 1 {
                per_button_text += ", work \(stitches_between_buttonholes!) sts"
            } else {
                per_button_text += ", work \(stitches_between_buttonholes!) st"
            }
            
            if number_of_buttons > 1 {
                inner_text += "[\(per_button_text)] \(number_of_buttons) times"
            } else {
                inner_text = per_button_text
            }

        }
        
        return inner_text
    }
    
    
    
    func final_instruction_text() -> String {
    
        if final_stitches > 1 {
            return "work \(final_stitches) sts"
        } else {
            return "work \(final_stitches) st"
        }
    }
    
    
}
        