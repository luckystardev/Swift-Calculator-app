//
//  stitch_calculation_tests.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/29/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation


import XCTest


class HelperFunctionTests: XCTestCase {
    
    
    func test_inches_to_cm() {
        XCTAssertEqual(convert_inches_to_cm(1.0), Float(2.54))
        XCTAssertEqual(convert_inches_to_cm(0.0), Float(0.0))
        XCTAssertEqual(convert_inches_to_cm(0.5), Float(1.27))
        XCTAssertEqual(convert_inches_to_cm(100.0), Float(254.0))
        XCTAssertEqual(convert_inches_to_cm(-1.0), Float(-2.54))

        XCTAssertEqual(convert_per_inch_to_per_ten_cm(2.54), Float(10))
    
    }
    
    func test_cm_to_inches() {
        XCTAssertEqual(convert_cm_to_inches(1.0), Float(1) / Float(2.54))
        XCTAssertEqual(convert_cm_to_inches(2.54), Float(1))
        XCTAssertEqual(convert_cm_to_inches(0.0), Float(0))
        XCTAssertEqual(convert_cm_to_inches(-1.0), Float(1) / Float(-2.54))
        
        XCTAssertEqual(convert_per_ten_cm_to_per_inch(10), Float(2.54))
    }

}


class FractionTests: XCTestCase  {
    
    
    func testAsString() {
        XCTAssertEqual(Fraction.None.asString(), "-")
        XCTAssertEqual(Fraction.Quarter.asString(), "\u{00BC}")
        XCTAssertEqual(Fraction.Half.asString(), "\u{00BD}")
        XCTAssertEqual(Fraction.ThreeQuarter.asString(), "\u{00BE}")
    }
    
    func testToFloat() {
        XCTAssertEqual(Fraction.None.toFloat(), Float(0.0))
        XCTAssertEqual(Fraction.Quarter.toFloat(), Float(0.25))
        XCTAssertEqual(Fraction.Half.toFloat(), Float(0.5))
        XCTAssertEqual(Fraction.ThreeQuarter.toFloat(), Float(0.75))
    }


    func testFromFloat() {
        XCTAssertEqual(Fraction.fromFloat(0.0)!, Fraction.None)
        XCTAssertEqual(Fraction.fromFloat(0.25)!, Fraction.Quarter)
        XCTAssertEqual(Fraction.fromFloat(0.5)!, Fraction.Half)
        XCTAssertEqual(Fraction.fromFloat(0.75)!, Fraction.ThreeQuarter)
        XCTAssertTrue(Fraction.fromFloat(0.6) == nil)
        XCTAssertTrue(Fraction.fromFloat(1.0) == nil)
        XCTAssertTrue(Fraction.fromFloat(10.0) == nil)
        XCTAssertTrue(Fraction.fromFloat(-0.25) == nil)
    }
}

class MeasurementTest: XCTestCase  {
    
    func testInits() {
        
        XCTAssertEqual(Measurement(float_val: 0.0)!.whole_part, 0)
        XCTAssertEqual(Measurement(float_val: 0.0)!.fraction, Fraction.None)

        XCTAssertEqual(Measurement(float_val: 1.25)!.whole_part, 1)
        XCTAssertEqual(Measurement(float_val: 1.25)!.fraction, Fraction.Quarter)
        
        XCTAssertEqual(Measurement(float_val: 2.5)!.whole_part, 2)
        XCTAssertEqual(Measurement(float_val: 2.5)!.fraction, Fraction.Half)
        
        XCTAssertEqual(Measurement(float_val: 3.75)!.whole_part, 3)
        XCTAssertEqual(Measurement(float_val: 3.75)!.fraction, Fraction.ThreeQuarter)
        
        XCTAssertEqual(Measurement(float_val: 4.0)!.whole_part, 4)
        XCTAssertEqual(Measurement(float_val: 4.0)!.fraction, Fraction.None)
        
        XCTAssertNil(Measurement(float_val: -1.0))
        XCTAssertNil(Measurement(float_val: -1.25))
        
        XCTAssertNil(Measurement(whole_part: -1, fraction: Fraction.None))

    }
    
    func testToFloat() {
        XCTAssertEqual(Measurement(float_val: 1.25)!.toFloat(), Float(1.25))
        XCTAssertEqual(Measurement(whole_part: 1,
            fraction: Fraction.Quarter)!.toFloat(), Float(1.25))
    }
    
    
    func testRounding() {
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.0)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.0)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.05)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.05)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(1.15)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestQuarter(1.15)!.fraction,
            Fraction.Quarter)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.25)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.25)!.fraction,
            Fraction.Quarter)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(1.30)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestQuarter(1.30)!.fraction,
            Fraction.Quarter)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(10.4)!.whole_part, 10)
        XCTAssertEqual(Measurement.roundToNearestQuarter(10.4)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(10.5)!.whole_part, 10)
        XCTAssertEqual(Measurement.roundToNearestQuarter(10.5)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.6)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.6)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.65)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.65)!.fraction,
            Fraction.ThreeQuarter)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.75)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.75)!.fraction,
            Fraction.ThreeQuarter)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.8)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.8)!.fraction,
            Fraction.ThreeQuarter)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.9)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestQuarter(0.9)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestQuarter(1.0)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestQuarter(1.0)!.fraction,
            Fraction.None)
        
        XCTAssertNil(Measurement.roundToNearestQuarter(-10.0))
        
        
        

        XCTAssertEqual(Measurement.roundToNearestHalf(0.0)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.0)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.05)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.05)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(1.15)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestHalf(1.15)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.25)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.25)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(1.30)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestHalf(1.30)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(10.4)!.whole_part, 10)
        XCTAssertEqual(Measurement.roundToNearestHalf(10.4)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(10.5)!.whole_part, 10)
        XCTAssertEqual(Measurement.roundToNearestHalf(10.5)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.6)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.6)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.65)!.whole_part, 0)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.65)!.fraction,
            Fraction.Half)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.75)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.75)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.8)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.8)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(0.9)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestHalf(0.9)!.fraction,
            Fraction.None)
        
        XCTAssertEqual(Measurement.roundToNearestHalf(1.0)!.whole_part, 1)
        XCTAssertEqual(Measurement.roundToNearestHalf(1.0)!.fraction,
            Fraction.None)

        XCTAssertNil(Measurement.roundToNearestHalf(-10.0))

    }
    
}




class LengthTest: XCTestCase  {
    
    func testChangeSystem1() {
        let x = Length(measurement: Measurement(float_val: 4.0)!,
            measurement_system: .Imperial)

        
        let y = x.changeMeasurementSystem(.Imperial)
        XCTAssertEqual(y.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(y.measurement.whole_part, 4)
        XCTAssertEqual(y.measurement.fraction, Fraction.None)

        
        let z = x.changeMeasurementSystem(.Metric)
        XCTAssertEqual(z.measurement_system, MeasurementSystem.Metric)
        XCTAssertEqual(z.measurement.whole_part, 10)
        XCTAssertEqual(z.measurement.fraction, Fraction.None)
    }

    func testChangeSystem2() {
        let x = Length(measurement: Measurement(float_val: 40.0)!,
            measurement_system: .Metric)
        
        
        let y = x.changeMeasurementSystem(.Metric)
        XCTAssertEqual(y.measurement_system, MeasurementSystem.Metric)
        XCTAssertEqual(y.measurement.whole_part, 40)
        XCTAssertEqual(y.measurement.fraction, Fraction.None)
        
        
        let z = x.changeMeasurementSystem(.Imperial)
        XCTAssertEqual(z.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(z.measurement.whole_part, 15)
        XCTAssertEqual(z.measurement.fraction, Fraction.ThreeQuarter)
    }

}


class GaugeTests: XCTestCase {
    
    func testInits() {
        
        let g1 = Gauge(measurement_system: .Imperial,
            stitches_per: Measurement(float_val: 5.5)!)
        XCTAssertEqual(g1.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(g1.stitches_per.whole_part, 5)
        XCTAssertEqual(g1.stitches_per.fraction, Fraction.Half)
        
        let g2 = Gauge(measurement_system: .Metric,
            stitches_per: Measurement(float_val: 20.5)!)
        XCTAssertEqual(g2.measurement_system, MeasurementSystem.Metric)
        XCTAssertEqual(g2.stitches_per.whole_part, 20)
        XCTAssertEqual(g2.stitches_per.fraction, Fraction.Half)
        
        
        let g3 = Gauge(stitch_count: 22,
            length: Length(measurement: Measurement(float_val: 4.0)!,
                measurement_system: .Imperial))!
        XCTAssertEqual(g3.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(g3.stitches_per.whole_part, 5)
        XCTAssertEqual(g3.stitches_per.fraction, Fraction.Half)

        let g4 = Gauge(stitch_count: 41,
            length: Length(measurement: Measurement(float_val: 20.0)!,
                measurement_system: .Metric))!
        XCTAssertEqual(g4.measurement_system, MeasurementSystem.Metric)
        XCTAssertEqual(g4.stitches_per.whole_part, 20)
        XCTAssertEqual(g4.stitches_per.fraction, Fraction.Half)
        
        let l = Length(measurement: Measurement(float_val: 4.0)!,
                measurement_system: .Imperial)
        XCTAssertNil(Gauge(stitch_count: 0, length: l))
        XCTAssertNil(Gauge(stitch_count: -1, length: l))
    }
    
    func testLengthOfStitchCount() {
        let g1 = Gauge(measurement_system: .Imperial,
            stitches_per: Measurement(float_val: 5.5)!)
        let l1 = g1.lengthOfStitchCount(15)
        XCTAssertEqual(l1.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(l1.measurement.whole_part, 2)
        XCTAssertEqual(l1.measurement.fraction, Fraction.ThreeQuarter)

        
        let g2 = Gauge(measurement_system: .Metric,
            stitches_per: Measurement(float_val: 20.5)!)
        let l2 = g2.lengthOfStitchCount(40)
        XCTAssertEqual(l2.measurement_system, MeasurementSystem.Metric)
        XCTAssertEqual(l2.measurement.whole_part, 19)
        XCTAssertEqual(l2.measurement.fraction, Fraction.Half)
        
    }
    
}




class StitchCalculationTestCase: XCTestCase {
    
    let g = Gauge(measurement_system: MeasurementSystem.Imperial,
        stitches_per: Measurement(float_val: 5.5)!)
    let l = Length(measurement: Measurement(float_val: 10)!,
        measurement_system: MeasurementSystem.Imperial)
    let sc : Int = 55
    
    
    func testInits() {
    
        let sc1 = StitchCalculation(gauge: self.g, length: self.l)!
        XCTAssertEqual(sc1.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(sc1.stitches_per.whole_part, 5)
        XCTAssertEqual(sc1.stitches_per.fraction, Fraction.Half)
        XCTAssertEqual(sc1.stitch_count, 55)
        XCTAssertEqual(sc1.length_val.whole_part, 10)
        XCTAssertEqual(sc1.length_val.fraction, Fraction.None)
        
        
        let sc2 = StitchCalculation(stitch_count: self.sc, length: self.l)!
        XCTAssertEqual(sc2.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(sc2.stitches_per.whole_part, 5)
        XCTAssertEqual(sc2.stitches_per.fraction, Fraction.Half)
        XCTAssertEqual(sc2.stitch_count, 55)
        XCTAssertEqual(sc2.length_val.whole_part, 10)
        XCTAssertEqual(sc2.length_val.fraction, Fraction.None)
        
        
        let sc3 = StitchCalculation(stitch_count: self.sc, gauge: self.g)!
        XCTAssertEqual(sc3.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(sc3.stitches_per.whole_part, 5)
        XCTAssertEqual(sc3.stitches_per.fraction, Fraction.Half)
        XCTAssertEqual(sc3.stitch_count, 55)
        XCTAssertEqual(sc3.length_val.whole_part, 10)
        XCTAssertEqual(sc3.length_val.fraction, Fraction.None)
    
    }
    
    
    func testComputedProperties() {
        let sc1 = StitchCalculation(gauge: self.g, length: self.l)!
        let computed_g = sc1.gauge
        XCTAssertEqual(computed_g.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(computed_g.stitches_per.whole_part, 5)
        XCTAssertEqual(computed_g.stitches_per.fraction, Fraction.Half)

        let computed_l = sc1.length
        XCTAssertEqual(computed_l.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(computed_l.measurement.whole_part, 10)
        XCTAssertEqual(computed_l.measurement.fraction, Fraction.None)
        
        XCTAssertEqual(sc1.valid_fractions,
            [Fraction.None, Fraction.Quarter, Fraction.Half, Fraction.ThreeQuarter])
        
    }


    func testGaugeOptions() {
        let sc1 = StitchCalculation(gauge: self.g, length: self.l)!

        XCTAssertEqual(
            sc1.make_gauge_whole_part_options(1, max_stitches_per_inch: 15.0),
            [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
        XCTAssertEqual(
            sc1.make_gauge_whole_part_options(1, max_stitches_per_inch: 2),
            [1,2,3,4,5])
        XCTAssertEqual(
            sc1.make_gauge_whole_part_options(10, max_stitches_per_inch: 15),
            [5,6,7,8,9,10,11,12,13,14,15])


    
        let sc2 = StitchCalculation(stitch_count: 15,
            length: Length(
                measurement:
                    Measurement(float_val: 10.0)!,
                        measurement_system: MeasurementSystem.Metric))!

        XCTAssertEqual(
            sc2.make_gauge_whole_part_options(2, max_stitches_per_inch: 5),
            [7,8,9,10,11,12,13,14,15,16,17,18,19])

        XCTAssertEqual(
            sc2.make_gauge_whole_part_options(4, max_stitches_per_inch: 5),
            [15,16,17,18,19])

        XCTAssertEqual(
            sc2.make_gauge_whole_part_options(2, max_stitches_per_inch: 3),
            [7,8,9,10,11,12,13,14,15])

        
    }

    
    
    
    func testLengthOptions() {
        let sc1 = StitchCalculation(gauge: self.g, length: self.l)!
        
        XCTAssertEqual(
            sc1.make_length_whole_part_options(5, max_length_inches: 15.0),
            [5,6,7,8,9,10,11,12,13,14,15])
        XCTAssertEqual(
            sc1.make_length_whole_part_options(12, max_length_inches: 15),
            [10,11,12,13,14,15])
        XCTAssertEqual(
            sc1.make_length_whole_part_options(5, max_length_inches: 6),
            [5,6,7,8,9,10])
        
        
        
        let sc2 = StitchCalculation(stitch_count: 15,
            length: Length(
                measurement:
                Measurement(float_val: 10.0)!,
                measurement_system: MeasurementSystem.Metric))!
        
        XCTAssertEqual(
            sc2.make_length_whole_part_options(2, max_length_inches: 7),
            [5,6,7,8,9,10,11,12,13,14,15,16,17])
        
        XCTAssertEqual(
            sc2.make_length_whole_part_options(2, max_length_inches: 3),
            [5,6,7,8,9,10])
        
        XCTAssertEqual(
            sc2.make_length_whole_part_options(6, max_length_inches: 7),
            [10,11,12,13,14,15,16,17])
        
        
    }

    
    
    
    func testStitchCountBounds() {
        let sc1 = StitchCalculation(stitch_count: self.sc, gauge: self.g)!
        
        XCTAssertEqual(
            sc1.find_min_stitches(50),
            50)
        XCTAssertEqual(
            sc1.find_min_stitches(57),
            55)
        XCTAssertEqual(
            sc1.find_max_stitches(60),
            60)
        XCTAssertEqual(
            sc1.find_max_stitches(53),
            55)
            }
    
    
    func testChangeMeasurementSystem() {
        
        let sc1 = StitchCalculation(stitch_count: self.sc, length: self.l)!
        let sc2 = sc1.changeMeasurementSystem(MeasurementSystem.Imperial)
        XCTAssertEqual(sc1.measurement_system, sc2.measurement_system)
        XCTAssertEqual(sc1.stitch_count, sc2.stitch_count)
        XCTAssertEqual(sc1.stitches_per.whole_part, sc2.stitches_per.whole_part)
        XCTAssertEqual(sc1.stitches_per.fraction, sc2.stitches_per.fraction)
        XCTAssertEqual(sc1.length_val.whole_part, sc2.length_val.whole_part)
        XCTAssertEqual(sc1.length_val.fraction, sc2.length_val.fraction)

    
        let sc3 = sc1.changeMeasurementSystem(MeasurementSystem.Metric)
        XCTAssertEqual(sc3.measurement_system, MeasurementSystem.Metric)
        XCTAssertEqual(sc3.stitch_count, sc1.stitch_count)
        XCTAssertEqual(sc3.stitches_per.whole_part, 21)
        XCTAssertEqual(sc3.stitches_per.fraction, Fraction.Half)
        XCTAssertEqual(sc3.length_val.whole_part, 25)
        XCTAssertEqual(sc3.length_val.fraction, Fraction.Half)
        
        let l4 = Length(measurement: Measurement(float_val: 100)!,
            measurement_system: MeasurementSystem.Metric)
        let sc4 : Int = 55
        let sc5 = StitchCalculation(stitch_count: sc4, length: l4)!
        let sc6 = sc5.changeMeasurementSystem(MeasurementSystem.Metric)
        XCTAssertEqual(sc5.measurement_system, sc6.measurement_system)
        XCTAssertEqual(sc5.stitch_count, sc6.stitch_count)
        XCTAssertEqual(sc5.stitches_per.whole_part, sc6.stitches_per.whole_part)
        XCTAssertEqual(sc5.stitches_per.fraction, sc6.stitches_per.fraction)
        XCTAssertEqual(sc5.length_val.whole_part, sc6.length_val.whole_part)
        XCTAssertEqual(sc5.length_val.fraction, sc6.length_val.fraction)

        let sc7 = sc5.changeMeasurementSystem(MeasurementSystem.Imperial)
        XCTAssertEqual(sc7.measurement_system, MeasurementSystem.Imperial)
        XCTAssertEqual(sc7.stitch_count, sc5.stitch_count)
        XCTAssertEqual(sc7.stitches_per.whole_part, 1)
        XCTAssertEqual(sc7.stitches_per.fraction, Fraction.Half)
        XCTAssertEqual(sc7.length_val.whole_part, 39)
        XCTAssertEqual(sc7.length_val.fraction, Fraction.Quarter)
    }
    
        
}




