//
//  shaping_result.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/17/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation



class ShapingResult: Equatable {
    
    //
    // stored properties
    //
    
    // Stitches before shaping starts. Must be positive
    let starting_stitches: Int
    
    // If True, shaping rows are increases. If false, decreases.
    let shaping_increases: Bool
    
    // Number of stitches increased or decreased per shaping row. Must be
    // postive (even for decreases).
    let shaping_row_delta: Int
    
    // Straight rows before (but not including) first shaping row. Must be
    // non-negative
    let rows_before_first_shaping_row: Int
    
    // Rows between shaping rows (but not including either shaping row)
    // May be nil if there is only one shaping row. Must be non-negative if
    // not nil.
    let rows_between_shaping_rows: Int?
    
    // Rows after (but not including) last shaping row. Must be non-negative.
    let rows_after_last_shaping_row: Int
    
    
    // Number of shaping rows in total. Must be positive.
    let number_of_shaping_rows: Int
    

    //
    // computed properties
    //
    
    
    // Total rows for doing the shaping
    var total_rows: Int {
        get {
            var return_me = rows_before_first_shaping_row
            return_me += rows_after_last_shaping_row
            return_me += number_of_shaping_rows
            if rows_between_shaping_rows != nil {
                return_me += rows_between_shaping_rows! * (number_of_shaping_rows - 1)
            }
            return return_me
        }
    }

    // Stitches after shaping ends
    var ending_stitches: Int {
        get {
            var stitches_shaped = shaping_row_delta * number_of_shaping_rows
            if shaping_increases {
                return starting_stitches + stitches_shaped
            } else {
                return starting_stitches - stitches_shaped
            }
        }
    }

    // The total number of stitches added or removed
    var total_stitch_delta : Int {
        return shaping_row_delta * number_of_shaping_rows
    }
    

    // Return the fewest rows needed to acomodate the shaping, assuming
    // the starting stitch-count, the ending sitch-count and shaping-delta of
    // this instance
    var min_total_rows: Int {
        return total_stitch_delta / shaping_row_delta
    }

    
    
    
    // Largest possible starting stitches, assuming the shaping_delta and 
    // total_rows do not change.
    var max_starting_stitches: Int {
        return ending_stitches + (total_rows * shaping_row_delta)
    }
    
    
    
    // Largest possible ending stitches, assuming the total_rows and
    // shaping_row delta do not change.
    var max_ending_stitches: Int {
        return starting_stitches + (total_rows * shaping_row_delta)
    }
    
    
    
    // smallest possible starting stitches, assuming total_rows and
    // shaping row delta do not change
    var min_starting_stitches: Int {
        get {
            let naive_limit =  ending_stitches - (total_rows * shaping_row_delta)
            if naive_limit >= 0 {
                return naive_limit
            } else {
                return ending_stitches % shaping_row_delta
            }
        }
    }
    
    // smallest possible ending stitches, assuming total_rows and shaping row 
    // delta do not change.
    var min_ending_stitches: Int {
        get {
            let naive_limit =  starting_stitches - (total_rows * shaping_row_delta)
            if naive_limit >= 0 {
                return naive_limit
            } else {
                return starting_stitches % shaping_row_delta
            }
        }
    }
    
    
    
    
    // Note: failable initializer
    init?(starting_stitches: Int,
        ending_stitches: Int,
        total_rows: Int,
        shaping_row_delta: Int,
        start_and_end_with_shaping_row: Bool) {
            
            self.starting_stitches = starting_stitches
            self.shaping_row_delta = shaping_row_delta
            
            // initial sanity checks
            if (starting_stitches <= 0)
                || (ending_stitches <= 0)
                || (total_rows <= 0)
                || (shaping_row_delta <= 0)
                || (starting_stitches == ending_stitches) {
                    // A bug in swift requires that we fully initialize the instance
                    // before the initializer can fail:
                    // http://stackoverflow.com/questions/26495586/best-practice-to-implement-a-failable-initializer-in-swift
                    // Okay:
                
                    shaping_increases = true
                    number_of_shaping_rows = 0
                    rows_before_first_shaping_row = 0
                    rows_after_last_shaping_row = 0
                    rows_between_shaping_rows = 0
                    
                    return nil
            }
            
            shaping_increases = (starting_stitches < ending_stitches)
            let stitch_diff = abs(starting_stitches - ending_stitches)
            // Note integer division: 5/3 == 1
            number_of_shaping_rows = stitch_diff / self.shaping_row_delta
            let spacing_result =
                start_and_end_with_shaping_row
                ?
                SpacingResult(total_units: total_rows,
                    number_of_events: number_of_shaping_rows,
                    units_per_event: 1,
                    interval_before_first_event: 0.0,
                    interval_after_last_event: 0.0)
                    :
                SpacingResult(total_units: total_rows,
                    number_of_events: number_of_shaping_rows,
                    units_per_event: 1)
            
            // More sanity checking-- does this rate of shaping make sense?
            if ((stitch_diff % self.shaping_row_delta) != 0)
                || (spacing_result == nil)
            {
            // A bug in swift requires that we fully initialize the instance
                // before the initializer can fail:
                // http://stackoverflow.com/questions/26495586/best-practice-to-implement-a-failable-initializer-in-swift
                // Okay:
                
                rows_before_first_shaping_row = 0
                rows_after_last_shaping_row = 0
                rows_between_shaping_rows = 0
                
                return nil
            } else {
                
                // Distribute extra stitches before setting final values
                var extra_stitches = spacing_result!.extra_units
                
                if spacing_result!.units_between_events == nil {
                    rows_between_shaping_rows = nil
                } else {
                    let number_interior_buckets = spacing_result!.number_of_events - 1
                    
                    if (extra_stitches >= number_interior_buckets) {
                        rows_between_shaping_rows = spacing_result!.units_between_events! + 1
                        extra_stitches -= number_interior_buckets
                    } else {
                        rows_between_shaping_rows = spacing_result!.units_between_events
                    }
                }
                
                
                var stitches_to_give = extra_stitches / 2
                rows_before_first_shaping_row = spacing_result!.units_before_first_event + stitches_to_give
                extra_stitches -= stitches_to_give
                rows_after_last_shaping_row = spacing_result!.units_after_last_event + extra_stitches
            
            }
            
            // Final validation of values
            if (starting_stitches <= 0)
                || (shaping_row_delta <= 0)
                || (number_of_shaping_rows <= 0)
                || (rows_before_first_shaping_row < 0)
                || (rows_after_last_shaping_row < 0)
                || ((rows_between_shaping_rows != nil)
                    && (rows_between_shaping_rows! < 0)) {
                        return nil
            }
            
    }

    // Used for creating specific instances for unit tests
    init(starting_stitches: Int,
        shaping_increases: Bool,
        shaping_row_delta: Int,
        rows_before_first_shaping_row: Int,
        rows_between_shaping_rows: Int?,
        rows_after_last_shaping_row: Int,
        number_of_shaping_rows: Int) {
            
            self.starting_stitches = starting_stitches
            self.shaping_increases = shaping_increases
            self.shaping_row_delta = shaping_row_delta
            self.rows_before_first_shaping_row = rows_before_first_shaping_row
            self.rows_between_shaping_rows = rows_between_shaping_rows
            self.rows_after_last_shaping_row = rows_after_last_shaping_row
            self.number_of_shaping_rows = number_of_shaping_rows
    }
    



    
    func make_instruction_texts() -> [String] {
        
        var return_me = [String]()
        
        var initial_text = ""
        var per_shaping_row_text = ""

        
        // rows_before_first_shaping_row must be non-negative
        switch rows_before_first_shaping_row {
        case 0:
            break
        case 1:
            return_me.append("work 1 row even")
        default:
            return_me.append("work \(rows_before_first_shaping_row) rows even")
        }
        
        
        
        var shaping_word = ""
        if shaping_increases {
            shaping_word = "increase"
        } else {
            shaping_word = "decrease"
        }
        per_shaping_row_text += "work \(shaping_word) row"
        
        
        var inner_text = ""
        if number_of_shaping_rows == 1 {
            inner_text = per_shaping_row_text
        } else {
            
            switch rows_between_shaping_rows! {
            case 0:
                inner_text = "\(per_shaping_row_text) \(number_of_shaping_rows) times"
            case 1:
                if number_of_shaping_rows == 2 {
                    inner_text = "\(per_shaping_row_text), work 1 row even, \(per_shaping_row_text)"
                } else {
                    // number_of_shaping_rows >= 3
                    var number_of_shaping_repeats = number_of_shaping_rows - 1
                    inner_text = "[\(per_shaping_row_text), work 1 row even] \(number_of_shaping_repeats) times, \(per_shaping_row_text)"
                }
            default:
                if number_of_shaping_rows == 2 {
                    inner_text = "\(per_shaping_row_text), work \(rows_between_shaping_rows!) rows even, \(per_shaping_row_text)"
                } else {
                    // number_of_shaping_rows >= 3
                    var number_of_shaping_repeats = number_of_shaping_rows - 1
                    inner_text = "[\(per_shaping_row_text), work \(rows_between_shaping_rows!) rows even] \(number_of_shaping_repeats) times, \(per_shaping_row_text)"
                }

            }
        }
        
        return_me.append(inner_text)
        
        switch rows_after_last_shaping_row {
        case 0:
            break
        case 1:
            return_me.append("work 1 row even")
        default:
            return_me.append("work \(rows_after_last_shaping_row) rows even")
        }
        
        return return_me
    
    }
    
    

    
    // Return true iff argument is a valid shaping-per-row for 
    // the current values of starting stitches, ending stitches, and total rows
    func is_compatible_stitch_delta(proposed_delta: Int) -> Bool{
        
        if (proposed_delta <= 0) || (proposed_delta > total_stitch_delta) {
            return false
        } else {
            let mod_right = ((total_stitch_delta % proposed_delta) == 0)
            let enough_rows  = total_rows >= (total_stitch_delta / proposed_delta)
            return mod_right && enough_rows
        }
    }
    
}



func ==(var lhs: ShapingResult, var rhs: ShapingResult) -> Bool {
    let component_eqs = [
        lhs.starting_stitches == rhs.starting_stitches,
        lhs.shaping_increases == rhs.shaping_increases,
        lhs.shaping_row_delta == rhs.shaping_row_delta,
        lhs.rows_before_first_shaping_row == rhs.rows_before_first_shaping_row,
        lhs.rows_between_shaping_rows == rhs.rows_between_shaping_rows,
        lhs.rows_after_last_shaping_row == rhs.rows_after_last_shaping_row,
        lhs.number_of_shaping_rows == rhs.number_of_shaping_rows
    ]
    return component_eqs.reduce(true, combine: {
        (x,y) -> Bool in x && y
    })
    
}




        