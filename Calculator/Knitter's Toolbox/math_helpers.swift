    //
//  math_helpers.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/7/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation



public enum RoundingDirection {
    case Up
    case Down
    case Any
}



public func kround_to_float(orig: Float,
    direction: RoundingDirection,
    multiple: Float,
    mod: Float) -> Float {
        
        // first, find 'lower': the largest value satisfying 'mod' mod
        //'multiple' lower than or equal to orig.
        
        let first_guess = floor(orig / multiple) * multiple
        var lower = first_guess + mod
        if lower > orig {
            lower -= multiple
        }
        
        // now find 'upper': the smallest value satisying
        //'mod' mod multiple larger than  or equal to orig
        
        var upper = first_guess
        if upper < orig {
            upper += multiple
        }
        if (upper - multiple + mod) >= orig {
            upper = upper - multiple + mod
        } else {
            upper = upper + mod
        }
        
        
        // If orig is really close to either upper or lower-- within the
        // noise of floating-point representation error-- return that one.
        
        if abs(upper - orig) < FLOATING_POINT_NOISE {
            return upper
        }
        if abs(orig - lower) < FLOATING_POINT_NOISE {
            return lower
        }
        
        
        // Okay, neither of those matched. We're in a real rounding case.
        switch direction {
        case .Up:
            return upper
        case .Down:
            return lower
        case .Any:
            if (orig - lower) < (upper - orig) {
                return lower
            } else {
                return upper
            }
        }
}







public func kround(orig: Float, direction: RoundingDirection = .Any,
    multiple: Int = 1, mod: Int = 0) -> Int {
        
        let result = kround_to_float(orig, direction, Float(multiple),Float(mod))
        return Int(result)
}




/**

Describes how to evenly space things over
a stretch of rows or stitches. This is a common need in knitting, where you 
need to evenly space button holes over a stretch of stitches, or to evenly
space shaping rows over a stretch of rows. 

For generality, we use the term 'unit' to refer to the way in which the 
distance is measured (rows or stitches) and 'event' to mean the thing being
spaced out (button hole or shaping row.



*/
class SpacingResult {

    
    // Number of units before first event (but not including the first event)
    // Will be non-negative, but can be zero
    let units_before_first_event: Int
    
    // Number of units after last event (but not including the last event)
    // Will be non-negative, but can be zero
    let units_after_last_event: Int
    
    // Number of units between each event (but not including either)
    // Will be nil if there is only one event. If non-nil, must be non-negative
    // but can be zero
    let units_between_events: Int?
    
    // Number of events. Must be positive
    let number_of_events: Int
    
    // Units consumed by each event. Must be positive
    let units_per_event: Int
    
    // 'Extra' units, that didn't quite fit anywhere. Must be non-negative.
    let extra_units: Int
  
    
    
    /** 

    Initializes a SpacingResult. Can fail.

    :param: total_units The total number of stitches or rows over which 
                to space out the events.
    :param: number_of_events The total number of button holes, spacing rows, etc.
    :param: units_per_event The number of units used by each event.
    :param: interval_before_first_event The proportion of an inter-event distance
        that should be before the first event. Defaults to 0.5
    :param: interval_after_last_event The proportion of an inter-event distance
        that should be after the last event. Defaults to 0.5
    */
    init?(total_units: Int, number_of_events: Int, units_per_event: Int,
        var interval_before_first_event: Float = 0.5,
        var interval_after_last_event: Float = 0.5) {
            
            
            self.units_per_event = units_per_event
            self.number_of_events = number_of_events
            
            if (total_units < 1)
                || (number_of_events < 1)
                || (units_per_event < 1)
                || (interval_before_first_event < 0.0)
                || (interval_after_last_event < 0.0) {
                    // A bug in swift requires that we fully initialize the instance
                    // before the initializer can fail:
                    // http://stackoverflow.com/questions/26495586/best-practice-to-implement-a-failable-initializer-in-swift
                    // Okay:
                    
                    units_before_first_event = 0
                    units_after_last_event = 0
                    units_between_events = 0
                    extra_units = 0
                    return nil
            }
            
            // Compute values under assumption that they will work
            
            let num_inter_event_intervals = number_of_events - 1
            
            let units_in_events = number_of_events * units_per_event
            let remaining_units = total_units - units_in_events
            var num_intervals = Float(num_inter_event_intervals) + interval_after_last_event + interval_before_first_event
            // Catch a corner case:
            if num_intervals == 0 {
                // How could this be? If all of num_inter_event_intervals, 
                // interval_after_last_event and interval_before_first_event
                // are all zero. And if num_inter_event_intervals is 0, them
                // number_of_events must be 1. Put the single event in the middle.
                
                interval_after_last_event = 0.5
                interval_before_first_event = 0.5
                num_intervals = 1.0
                
                
            }
            let units_per_interval_float = Float(remaining_units) / num_intervals
            
            // First, be conservitive: round everything down and see how many extra
            // stitches are left over
            var units_before_first_event_temp =
            kround(interval_before_first_event * units_per_interval_float,
                direction: .Down)
            var units_after_last_event_temp =
            kround(interval_after_last_event * units_per_interval_float,
                direction: .Down)
            var extra_units_temp = remaining_units
            extra_units_temp -= units_before_first_event_temp
            extra_units_temp -= units_after_last_event_temp
            
            var units_between_events_temp: Int? = nil
            
            if number_of_events > 1 {
                units_between_events_temp =
                    kround(units_per_interval_float,
                        direction: .Down)
                extra_units_temp -= units_between_events_temp! * (number_of_events - 1)
            }
            
            
            // Did we round anything to zero? If so, use extra stitches to
            // bring them up to one-- if possible
            
            
            if (units_before_first_event_temp <= 0)
                && (extra_units_temp > 0)
                && (interval_before_first_event > 0.0) {
                    units_before_first_event_temp += 1
                    extra_units_temp -= 1
            }
            
            if (units_after_last_event_temp <= 0)
                && (extra_units_temp > 0)
                && (interval_after_last_event > 0.0){
                    units_after_last_event_temp += 1
                    extra_units_temp -= 1
            }
            
            if units_between_events_temp != nil {
                if (units_between_events_temp! <= 0)
                    && (extra_units_temp > num_inter_event_intervals) {
                        units_between_events_temp! += 1
                        extra_units_temp -= num_inter_event_intervals
                }
            }
            
            
            // Assign final values
            units_after_last_event = units_after_last_event_temp
            units_before_first_event = units_before_first_event_temp
            units_between_events = units_between_events_temp
            extra_units = extra_units_temp
            
            
            // Check for failure. (Must be done after all stored properties
            // are initialized, for some reason.)
            
            if units_before_first_event < 0 { return nil }
            if units_after_last_event < 0 { return nil }
            if extra_units < 0 { return nil }
            if (units_between_events != nil) && (units_between_events! < 0) {
                return nil
            }
            
            
    }
    
    func total_units() -> Int {
        var return_me = 0
        // Before first
        return_me += units_before_first_event
        // after last
        return_me += units_after_last_event
        // events
        return_me += (units_per_event * number_of_events)
        // Between events
        if let x =  units_between_events {
            return_me += x * (number_of_events  - 1)
        }
        // Extra units
        return_me += extra_units
        
        return return_me
    }

    
    
}
