//
//  stitch_calculation.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/27/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation




//
// helper functions
//

func convert_inches_to_cm(inches: Float) -> Float {
    return inches * 2.54
}

func convert_cm_to_inches(cm: Float) -> Float {
    return cm / 2.54
}


func convert_per_inch_to_per_ten_cm(per_inches: Float) -> Float {
    return convert_cm_to_inches(per_inches) * 10.0
}

func convert_per_ten_cm_to_per_inch(per_ten_cm: Float) -> Float {
    return convert_inches_to_cm(per_ten_cm /  10.0)
}



enum MeasurementSystem {
    case Imperial
    case Metric
    
    static let asArray = [Imperial, Metric]
}

enum Fraction {
    case None, Quarter, Half, ThreeQuarter
    
    func asString() -> String {
        switch self {
        case None:
            return "-"
        case Quarter:
            return "\u{00BC}"
        case Half:
            return "\u{00BD}"
        case ThreeQuarter:
            return "\u{00BE}"
        }
    }
    
    func toFloat() -> Float {
        switch self {
        case None:
            return 0.0
        case Quarter:
            return 0.25
        case Half:
            return 0.5
        case ThreeQuarter:
            return 0.75
        }
    }

    static func fromFloat(float_val: Float) -> Fraction? {
        switch float_val {
        case 0.0:
            return None
        case 0.25:
            return Quarter
        case 0.5:
            return Half
        case 0.75:
            return ThreeQuarter
        default:
            return nil
        }
    }
    

}

class Measurement {

    let whole_part: Int
    let fraction: Fraction

    init?(whole_part: Int, fraction: Fraction) {
            self.whole_part = whole_part
            self.fraction = fraction
        if whole_part < 0 {
            return nil
        }
    }
    
    init?(float_val: Float) {
        if float_val < 0 {
            whole_part = 0
            fraction = .None
            return nil
        }
        whole_part = Int(float_val)
        let fraction_float = float_val - Float(whole_part)
        if Fraction.fromFloat(fraction_float) == nil {
            fraction = .None
            return nil
        }
        fraction = Fraction.fromFloat(fraction_float)!
    }
    
    func toFloat() -> Float {
        return Float(whole_part) + fraction.toFloat()
    }
    
    func toString() -> String {
        switch fraction {
        case .None:
            return "\(whole_part)"
        default:
            return "\(whole_part)\(fraction.asString())"
        }
    }
    
    private class func _roundToNearest(float_val: Float,
        multiple: Float) -> Float? {
            if (float_val >= 1) || (float_val < 0) {
                return nil
            }
            if find([0.0, 0.25, 0.5, 0.75], multiple) == nil {
                return nil
            }
            
            var temp = float_val / multiple
            temp = Float(kround(temp))
            temp = temp * multiple
            return temp
    }
    

    
    class func roundToNearestHalf(float_val: Float) -> Measurement? {
        if float_val < 0 {
            return nil
        }
        let whole_part = Int(float_val)
        let frac_float = float_val - Float(whole_part)
        let rounded_frac = _roundToNearest(frac_float, multiple: 0.5)
        if rounded_frac == 1.0 {
            return Measurement(whole_part: whole_part+1, fraction: .None)!
        } else {
            return Measurement(whole_part: whole_part,
                fraction: Fraction.fromFloat(rounded_frac!)!)!
        }
    }

    class func roundToNearestQuarter(float_val: Float) -> Measurement? {
        if float_val < 0 {
            return nil
        }
        let whole_part = Int(float_val)
        let frac_float = float_val - Float(whole_part)
        let rounded_frac = _roundToNearest(frac_float, multiple: 0.25)
        if rounded_frac == 1.0 {
            return Measurement(whole_part: whole_part+1, fraction: .None)!
        } else {
            return Measurement(whole_part: whole_part,
                fraction: Fraction.fromFloat(rounded_frac!)!)!
        }
    }
}
    
    
class Length {
    let measurement : Measurement
    let measurement_system: MeasurementSystem
    
    init(measurement: Measurement, measurement_system: MeasurementSystem) {
        self.measurement = measurement
        self.measurement_system = measurement_system
    }
    
    func changeMeasurementSystem(new_measurement_system: MeasurementSystem)
        -> Length {
            
            if new_measurement_system == measurement_system {
                return self
            } else {
                let old_length_float = measurement.toFloat()
                switch measurement_system {
                case .Imperial:
                    // Switch to metric
                    let new_length_float =
                        convert_inches_to_cm(old_length_float)
                    let new_measurement =
                        Measurement.roundToNearestHalf(new_length_float)!
                    return Length(measurement: new_measurement,
                        measurement_system: new_measurement_system)
                case .Metric:
                    // Switch to Imperial
                    let new_length_float =
                        convert_cm_to_inches(old_length_float)
                    let new_measurement =
                        Measurement.roundToNearestQuarter(new_length_float)!
                    return Length(measurement: new_measurement,
                        measurement_system: new_measurement_system)
                }
            }
    }
    
    func toString() -> String {
        switch measurement_system {
        case .Imperial:
            return "\(measurement.toString()) in"
        case .Metric:
            return "\(measurement.toString()) cm"
        }
    }
}




class Gauge {
    
    let measurement_system: MeasurementSystem

    // Will be per inch or per 10 cm
    let stitches_per : Measurement
    
    init(measurement_system: MeasurementSystem,
        stitches_per: Measurement) {

            self.measurement_system = measurement_system
            self.stitches_per = stitches_per
    }
    
    init?(stitch_count: Int, length: Length) {
        measurement_system = length.measurement_system
        if stitch_count <= 0 {
            stitches_per = Measurement(float_val: 1.0)!
            return nil
        }
        
        var gauge_float = Float(stitch_count) / length.measurement.toFloat()
        
        if measurement_system == .Metric {
            gauge_float *= 10
        }
        stitches_per = Measurement.roundToNearestHalf(gauge_float)!
        
    }

    func toString() -> String {
        switch measurement_system {
        case .Imperial:
            return "\(stitches_per.toString()) sts / in"
        case .Metric:
            return "\(stitches_per.toString()) sts / 10cm"
        }
    }

    func lengthOfStitchCount(stitch_count: Int) -> Length {
        var length_val = Float(stitch_count) / stitches_per.toFloat()
        var measurement: Measurement
        switch measurement_system {
        case .Imperial:
            measurement = Measurement.roundToNearestQuarter(length_val)!
        case .Metric:
            length_val *= 10
            measurement = Measurement.roundToNearestHalf(length_val)!
        }
        return Length(measurement: measurement,
            measurement_system: measurement_system)
    }

}


class StitchCalculation{
    
    let measurement_system: MeasurementSystem

    let stitches_per: Measurement
    let stitch_count: Int
    let length_val: Measurement
    
    
    
    //
    // Computed Properties
    //
    
    var gauge : Gauge {
        return Gauge(measurement_system: measurement_system, stitches_per: stitches_per)
    }
    
    var length : Length {
        return Length(measurement: length_val, measurement_system: measurement_system)
    }
    
    
    var valid_fractions : [Fraction] {
        get {
            switch measurement_system {
            case .Imperial:
                return [.None, .Quarter, .Half, .ThreeQuarter]
            case .Metric:
                return [.None, .Half]
            }
        }
    }
    
    
    
    //
    // Initializers
    //
    
    init?(gauge: Gauge, length: Length) {
        measurement_system = gauge.measurement_system
        stitches_per = gauge.stitches_per
        length_val = length.measurement

        // TODO: validation
        let stitch_val_float = length_val.toFloat() * stitches_per.toFloat()
        stitch_count = kround(stitch_val_float)
    }
    
    
    init?(stitch_count: Int, length: Length) {
        measurement_system = length.measurement_system
        length_val = length.measurement
        self.stitch_count = stitch_count
        
        // TODO: validation
        
        let gauge = Gauge(stitch_count: stitch_count, length: length)!
        
        self.stitches_per = gauge.stitches_per
    }
    
    
    init?(stitch_count: Int, gauge: Gauge) {
        measurement_system = gauge.measurement_system
        stitches_per = gauge.stitches_per
        self.stitch_count = stitch_count
        
        // TODO: Validation
        let length = gauge.lengthOfStitchCount(stitch_count)
        length_val = length.measurement
    }
    
    
    
    //
    // Valid options
    //
    
    // Return the smallest list of continuous Integers that contain all of
    // min_stitches_per_inch, max_stitches_per_inch, and the current gauge.
    // It must be guaranteed that the (whole part of) the current gauge is
    // in this list. Note that this list will depend on the measurement system 
    // in effect: if Imperial, then the resulting list will be whole parts for
    // stitches per inch. If Metric, then the resulting list will be whole parts
    // for stitches per 10 cm.
    func make_gauge_whole_part_options(min_stitches_per_inch: Float,
        max_stitches_per_inch: Float) -> [Int] {
            
            
            var min_value = 0
            var max_value = 0

            switch measurement_system {
            case .Imperial:
                min_value = min(stitches_per.whole_part,
                                Int(min_stitches_per_inch))
                max_value = max(stitches_per.whole_part,
                                Int(max_stitches_per_inch))
    
            case .Metric:
                min_value = min(stitches_per.whole_part,
                        Int(convert_per_inch_to_per_ten_cm(min_stitches_per_inch)))
                max_value = max(stitches_per.whole_part,
                        Int(convert_per_inch_to_per_ten_cm(max_stitches_per_inch)))
            }

            
            var return_me : [Int] = []
            for x in min_value...max_value {
                return_me.append(x)
            }
            return return_me
    }

    
    // Return the smallest list of continuous Integers that contain all of
    // min_length_inches, max_length_inches, and the current length.
    // It must be guaranteed that the (whole part of) the current length is
    // in this list. Note that this list will depend on the measurement system
    // in effect: if Imperial, then the resulting list will be whole parts for
    // lengths in inches. If Metric, then the resulting list will be whole parts
    // for stitches in cm.
    func make_length_whole_part_options(min_length_inches: Float,
        max_length_inches: Float) -> [Int] {
            
            
            var min_value = 0
            var max_value = 0
            
            switch measurement_system {
            case .Imperial:
                min_value = min(length_val.whole_part,
                    Int(min_length_inches))
                max_value = max(length_val.whole_part,
                    Int(max_length_inches))
                
            case .Metric:
                min_value = min(length_val.whole_part,
                    Int(convert_inches_to_cm(min_length_inches)))
                max_value = max(length_val.whole_part,
                    Int(convert_inches_to_cm(max_length_inches)))
            }
            
            
            var return_me : [Int] = []
            for x in min_value...max_value {
                return_me.append(x)
            }
            return return_me
    }
    
    
    // Return the largest and smallest legal number of stitches, given
    // a bound
    func find_max_stitches(external_bound: Int) -> Int {
        return max(stitch_count, external_bound)
    }
    
    func find_min_stitches(external_bound: Int) -> Int {
        return min(stitch_count, external_bound)
    }

    
    
    
    func changeMeasurementSystem(new_measurement_system: MeasurementSystem) -> StitchCalculation {
        
        if new_measurement_system == self.measurement_system {
            return self
        } else {
            let new_length =
                self.length.changeMeasurementSystem(new_measurement_system)
            return StitchCalculation(stitch_count: self.stitch_count, length: new_length)!
            
        }
    }
    
    func make_gauge_text() -> String {
        return self.gauge.toString()
    }
    
    func make_length_text() -> String {
        return self.length.toString()
    }
    
    func make_stitch_text() -> String {
        if stitch_count > 1 {
            return "\(stitch_count) stitches"
        } else {
            return "\(stitch_count) stitch"
        }
    }
    

}