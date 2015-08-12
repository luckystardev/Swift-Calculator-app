//
//  math_helper_tests.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/7/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//


import Foundation
import XCTest


class RoundingTests: XCTestCase {
    
    
    func test_kround() {
        XCTAssertEqual(kround(0.75), 1)
        XCTAssertEqual(kround(0.25), 0)
        XCTAssertEqual(kround(0), 0)
        XCTAssertEqual(kround(1), 1)
        XCTAssertEqual(kround(0.75, direction: .Down), 0)
        XCTAssertEqual(kround(0.25, direction: .Down), 0)
        XCTAssertEqual(kround(0, direction: .Down), 0)
        XCTAssertEqual(kround(1, direction: .Down), 1)
        XCTAssertEqual(kround(0.75, direction: .Up), 1)
        XCTAssertEqual(kround(0.25, direction: .Up), 1)
        XCTAssertEqual(kround(0, direction: .Up), 0)
        XCTAssertEqual(kround(1, direction: .Up), 1)
        
        XCTAssertEqual(kround(2.1, multiple: 3), 3)
        XCTAssertEqual(kround(2.1, direction: .Any, multiple: 3), 3)
        XCTAssertEqual(kround(2.1, direction: .Up, multiple: 3), 3)
        XCTAssertEqual(kround(2.1, direction: .Down, multiple: 3), 0)
        
        XCTAssertEqual(kround(2.1, multiple: 5, mod: 2), 2)
        XCTAssertEqual(kround(2.1, direction: .Any, multiple: 5, mod: 2), 2)
        XCTAssertEqual(kround(2.1, direction: .Up, multiple: 5, mod: 2), 7)
        XCTAssertEqual(kround(2.1, direction: .Down, multiple: 5, mod: 2), 2)
        
        XCTAssertEqual(kround(6.1, multiple: 5, mod: 2), 7)
        XCTAssertEqual(kround(6.1, direction: .Any, multiple: 5, mod: 2), 7)
        XCTAssertEqual(kround(6.1, direction: .Up, multiple: 5, mod: 2), 7)
        XCTAssertEqual(kround(6.1, direction: .Down, multiple: 5, mod: 2), 2)
        
    }
    
    
    func test_integers_1() {
        for orig in [-1, 0, 1] {
            for d:RoundingDirection in [.Up, .Any, .Down] {
                let result = kround(Float(orig), direction: d, multiple: 1, mod: 0)
                XCTAssertEqual(result, orig)
            }
        }
    }
    
    func test_integers_2() {
        for orig in [-1, 0, 1] {
            let result = kround(Float(orig), multiple:1, mod:0)
            XCTAssertEqual(orig, result)
        }
    }
    
    
    func test_floats1() {
        XCTAssertEqual(kround(1.1), 1)
        XCTAssertEqual(kround(0.1), 0)
        XCTAssertEqual(kround(1.9), 2)
        XCTAssertEqual(kround(0.9), 1)
        XCTAssertEqual(kround(-1.9), -2)
        XCTAssertEqual(kround(-0.01), 0)
    }
    
    func test_floats_up() {
        XCTAssertEqual(kround(0.1, direction: .Up), 1)
        XCTAssertEqual(kround(0.9, direction: .Up), 1)
        XCTAssertEqual(kround(1.1, direction: .Up), 2)
        XCTAssertEqual(kround(-0.1, direction: .Up), 0)
        XCTAssertEqual(kround(-1.9, direction: .Up), -1)
    }
    
    func test_floats_down() {
        XCTAssertEqual(kround(0.1, direction: .Down), 0)
        XCTAssertEqual(kround(0.9, direction: .Down), 0)
        XCTAssertEqual(kround(1.1, direction: .Down), 1)
        XCTAssertEqual(kround(-0.1, direction: .Down), -1)
        XCTAssertEqual(kround(-1.9, direction: .Down), -2)
    }
    
    func test_floats_any() {
        XCTAssertEqual(kround(0.1, direction: .Any), 0)
        XCTAssertEqual(kround(0.9, direction: .Any), 1)
        XCTAssertEqual(kround(1.1, direction: .Any), 1)
        XCTAssertEqual(kround(-0.1, direction: .Any), 0)
        XCTAssertEqual(kround(-1.9, direction: .Any), -2)
        
        // Note: Amy specifically OKed the following asymmetry
        XCTAssertEqual(kround(0.5, direction: .Any), 1)
        XCTAssertEqual(kround(-0.5, direction: .Any), 0)
    }
    
    func test_mult() {
        XCTAssertEqual(kround(-5, multiple: 5), -5)
        XCTAssertEqual(kround(-4, multiple: 5), -5)
        XCTAssertEqual(kround(-3, multiple: 5), -5)
        XCTAssertEqual(kround(-2, multiple: 5), 0)
        XCTAssertEqual(kround(-1, multiple: 5), 0)
        XCTAssertEqual(kround(0, multiple: 5), 0)
        XCTAssertEqual(kround(1, multiple: 5), 0)
        XCTAssertEqual(kround(2, multiple: 5), 0)
        XCTAssertEqual(kround(3, multiple: 5), 5)
        XCTAssertEqual(kround(4, multiple: 5), 5)
        XCTAssertEqual(kround(5, multiple: 5), 5)
        XCTAssertEqual(kround(6, multiple: 5), 5)
        XCTAssertEqual(kround(7, multiple: 5), 5)
        XCTAssertEqual(kround(8, multiple: 5), 10)
        XCTAssertEqual(kround(9, multiple: 5), 10)
        XCTAssertEqual(kround(10, multiple: 5), 10)
    }
    
    func test_mult_any() {
        XCTAssertEqual(kround(-5, direction: .Any, multiple: 5), -5)
        XCTAssertEqual(kround(-4, direction: .Any, multiple: 5), -5)
        XCTAssertEqual(kround(-3, direction: .Any, multiple: 5), -5)
        XCTAssertEqual(kround(-2, direction: .Any, multiple: 5), 0)
        XCTAssertEqual(kround(-1, direction: .Any, multiple: 5), 0)
        XCTAssertEqual(kround(0, direction: .Any, multiple: 5), 0)
        XCTAssertEqual(kround(1, direction: .Any, multiple: 5), 0)
        XCTAssertEqual(kround(2, direction: .Any, multiple: 5), 0)
        XCTAssertEqual(kround(3, direction: .Any, multiple: 5), 5)
        XCTAssertEqual(kround(4, direction: .Any, multiple: 5), 5)
        XCTAssertEqual(kround(5, direction: .Any, multiple: 5), 5)
        XCTAssertEqual(kround(6, direction: .Any, multiple: 5), 5)
        XCTAssertEqual(kround(7, direction: .Any, multiple: 5), 5)
        XCTAssertEqual(kround(8, direction: .Any, multiple: 5), 10)
        XCTAssertEqual(kround(9, direction: .Any, multiple: 5), 10)
        XCTAssertEqual(kround(10, direction: .Any, multiple: 5), 10)
    }
    
    func test_mult_up() {
        XCTAssertEqual(kround(-5, direction: .Up, multiple: 5), -5)
        XCTAssertEqual(kround(-4, direction: .Up, multiple: 5), 0)
        XCTAssertEqual(kround(-3, direction: .Up, multiple: 5), 0)
        XCTAssertEqual(kround(-2, direction: .Up, multiple: 5), 0)
        XCTAssertEqual(kround(-1, direction: .Up, multiple: 5), 0)
        XCTAssertEqual(kround(0, direction: .Up, multiple: 5), 0)
        XCTAssertEqual(kround(1, direction: .Up, multiple: 5), 5)
        XCTAssertEqual(kround(2, direction: .Up, multiple: 5), 5)
        XCTAssertEqual(kround(3, direction: .Up, multiple: 5), 5)
        XCTAssertEqual(kround(4, direction: .Up, multiple: 5), 5)
        XCTAssertEqual(kround(5, direction: .Up, multiple: 5), 5)
        XCTAssertEqual(kround(6, direction: .Up, multiple: 5), 10)
        XCTAssertEqual(kround(7, direction: .Up, multiple: 5), 10)
        XCTAssertEqual(kround(8, direction: .Up, multiple: 5), 10)
        XCTAssertEqual(kround(9, direction: .Up, multiple: 5), 10)
        XCTAssertEqual(kround(10, direction: .Up, multiple: 5), 10)
    }
    
    func test_mult_down() {
        XCTAssertEqual(kround(-5, direction: .Down, multiple: 5), -5)
        XCTAssertEqual(kround(-4, direction: .Down, multiple: 5), -5)
        XCTAssertEqual(kround(-3, direction: .Down, multiple: 5), -5)
        XCTAssertEqual(kround(-2, direction: .Down, multiple: 5), -5)
        XCTAssertEqual(kround(-1, direction: .Down, multiple: 5), -5)
        XCTAssertEqual(kround(0, direction: .Down, multiple: 5), 0)
        XCTAssertEqual(kround(1, direction: .Down, multiple: 5), 0)
        XCTAssertEqual(kround(2, direction: .Down, multiple: 5), 0)
        XCTAssertEqual(kround(3, direction: .Down, multiple: 5), 0)
        XCTAssertEqual(kround(4, direction: .Down, multiple: 5), 0)
        XCTAssertEqual(kround(5, direction: .Down, multiple: 5), 5)
        XCTAssertEqual(kround(6, direction: .Down, multiple: 5), 5)
        XCTAssertEqual(kround(7, direction: .Down, multiple: 5), 5)
        XCTAssertEqual(kround(8, direction: .Down, multiple: 5), 5)
        XCTAssertEqual(kround(9, direction: .Down, multiple: 5), 5)
        XCTAssertEqual(kround(10, direction: .Down, multiple: 5), 10)
    }
    
    func test_mult_mod() {
        XCTAssertEqual(kround(-5, multiple: 5, mod: 3), -7)
        XCTAssertEqual(kround(-4, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-3, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-2, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-1, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(0, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(1, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(2, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(3, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(4, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(5, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(6, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(7, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(8, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(9, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(10, multiple: 5, mod: 3), 8)
    }
    
    func test_mult_mod_any() {
        XCTAssertEqual(kround(-5, direction: .Any, multiple: 5, mod: 3), -7)
        XCTAssertEqual(kround(-4, direction: .Any, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-3, direction: .Any, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-2, direction: .Any, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-1, direction: .Any, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(0, direction: .Any, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(1, direction: .Any, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(2, direction: .Any, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(3, direction: .Any, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(4, direction: .Any, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(5, direction: .Any, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(6, direction: .Any, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(7, direction: .Any, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(8, direction: .Any, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(9, direction: .Any, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(10, direction: .Any, multiple: 5, mod: 3), 8)
    }
    
    func test_mult_mod_up() {
        XCTAssertEqual(kround(-5, direction: .Up, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-4, direction: .Up, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-3, direction: .Up, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-2, direction: .Up, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-1, direction: .Up, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(0, direction: .Up, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(1, direction: .Up, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(2, direction: .Up, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(3, direction: .Up, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(4, direction: .Up, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(5, direction: .Up, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(6, direction: .Up, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(7, direction: .Up, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(8, direction: .Up, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(9, direction: .Up, multiple: 5, mod: 3), 13)
        XCTAssertEqual(kround(10, direction: .Up, multiple: 5, mod: 3), 13)
    }
    
    func test_mult_mod_down() {
        XCTAssertEqual(kround(-5, direction: .Down, multiple: 5, mod: 3), -7)
        XCTAssertEqual(kround(-4, direction: .Down, multiple: 5, mod: 3), -7)
        XCTAssertEqual(kround(-3, direction: .Down, multiple: 5, mod: 3), -7)
        XCTAssertEqual(kround(-2, direction: .Down, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(-1, direction: .Down, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(0, direction: .Down, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(1, direction: .Down, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(2, direction: .Down, multiple: 5, mod: 3), -2)
        XCTAssertEqual(kround(3, direction: .Down, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(4, direction: .Down, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(5, direction: .Down, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(6, direction: .Down, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(7, direction: .Down, multiple: 5, mod: 3), 3)
        XCTAssertEqual(kround(8, direction: .Down, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(9, direction: .Down, multiple: 5, mod: 3), 8)
        XCTAssertEqual(kround(10, direction: .Down, multiple: 5, mod: 3), 8)
    }
    
    
    func test_mult_mod2() {
        XCTAssertEqual(kround(-5, multiple: 4, mod: 2), -6)
        XCTAssertEqual(kround(-4, multiple: 4, mod: 2), -2)
        XCTAssertEqual(kround(-3, multiple: 4, mod: 2), -2)
        XCTAssertEqual(kround(-2, multiple: 4, mod: 2), -2)
        XCTAssertEqual(kround(-1, multiple: 4, mod: 2), -2)
        XCTAssertEqual(kround(0, multiple: 4, mod: 2), 2)
        XCTAssertEqual(kround(1, multiple: 4, mod: 2), 2)
        XCTAssertEqual(kround(2, multiple: 4, mod: 2), 2)
        XCTAssertEqual(kround(3, multiple: 4, mod: 2), 2)
        XCTAssertEqual(kround(4, multiple: 4, mod: 2), 6)
        XCTAssertEqual(kround(5, multiple: 4, mod: 2), 6)
        XCTAssertEqual(kround(6, multiple: 4, mod: 2), 6)
        XCTAssertEqual(kround(7, multiple: 4, mod: 2), 6)
        XCTAssertEqual(kround(8, multiple: 4, mod: 2), 10)
        XCTAssertEqual(kround(9, multiple: 4, mod: 2), 10)
        XCTAssertEqual(kround(10, multiple: 4, mod: 2), 10)
    }
    
    func test_floats_2() {
        XCTAssertEqual(kround_to_float(-2, .Any, 2.5,0.25), -2.25)
        XCTAssertEqual(kround_to_float(-1.66, .Any, 2.5, 0.25), -2.25)
        XCTAssertEqual(kround_to_float(-1.33, .Any, 2.5, 0.25), -2.25)
        XCTAssertEqual(kround_to_float(-1.0, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(-0.66, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(-0.33, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(0, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(0.33, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(0.66, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(1, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(1.33, .Any, 2.5, 0.25), 0.25 as Float)
        XCTAssertEqual(kround_to_float(1.66, .Any, 2.5, 0.25), 2.75 as Float)
        XCTAssertEqual(kround_to_float(2, .Any, 2.5, 0.25), 2.75 as Float)
        XCTAssertEqual(kround_to_float(2.33, .Any, 2.5, 0.25), 2.75 as Float)
        XCTAssertEqual(kround_to_float(2.66, .Any, 2.5, 0.25), 2.75 as Float)
        XCTAssertEqual(kround_to_float(3, .Any, 2.5, 0.25), 2.75 as Float)
    }
    
}








class SpacingResultTestsGood1: XCTestCase {
    
    
    func test_good_case1(){
        let sr = SpacingResult(total_units: 20, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 4)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 20)
    }
    
    func test_good_case2(){
        let sr = SpacingResult(total_units: 21, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 4)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 1)
        XCTAssertEqual(sr!.total_units(), 21)
    }
    
    func test_good_case3(){
        let sr = SpacingResult(total_units: 22, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 4)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 2)
        XCTAssertEqual(sr!.total_units(), 22)
    }
    
    func test_good_case4(){
        let sr = SpacingResult(total_units: 23, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 4)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 3)
        XCTAssertEqual(sr!.total_units(), 23)
    }
    
    func test_good_case5(){
        let sr = SpacingResult(total_units: 24, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 5)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 1)
        XCTAssertEqual(sr!.total_units(), 24)
    }
    
    func test_good_case6(){
        let sr = SpacingResult(total_units: 25, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 5)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 2)
        XCTAssertEqual(sr!.total_units(), 25)
    }
    
    func test_good_case7(){
        let sr = SpacingResult(total_units: 26, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 5)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 3)
        XCTAssertEqual(sr!.total_units(), 26)
    }
    
    func test_good_case8(){
        let sr = SpacingResult(total_units: 27, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 5)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 4)
        XCTAssertEqual(sr!.total_units(), 27)
    }
    
    func test_good_case9(){
        let sr = SpacingResult(total_units: 28, number_of_events: 4, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 3)
        XCTAssertEqual(sr!.units_after_last_event, 3)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 6)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 28)
    }
    
}







class SpacingResultTestsCornerCase: XCTestCase {
    
    
    func test_corner_case1(){
        let sr = SpacingResult(total_units: 9, number_of_events: 1, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 4)
        XCTAssertEqual(sr!.units_after_last_event, 4)
        XCTAssertNil(sr!.units_between_events)
        XCTAssertEqual(sr!.number_of_events, 1)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 9)
    }

    func test_corner_case2(){
        let sr = SpacingResult(total_units: 9, number_of_events: 9, units_per_event: 1)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 0)
        XCTAssertEqual(sr!.number_of_events, 9)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 9)
    }

    
    func test_corner_case3(){
        let sr = SpacingResult(total_units: 8, number_of_events: 2, units_per_event: 1,
            interval_before_first_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 2)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 4)
        XCTAssertEqual(sr!.number_of_events, 2)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 8)
    }

    
    func test_corner_case4(){
        let sr = SpacingResult(total_units: 8, number_of_events: 2, units_per_event: 1,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 2)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 4)
        XCTAssertEqual(sr!.number_of_events, 2)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 8)
    }
    
    
    
}






class SpacingResultUnitBookends: XCTestCase {

    func test_case1(){
        let sr = SpacingResult(total_units: 20, number_of_events: 4,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 5)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 1)
        XCTAssertEqual(sr!.total_units(), 20)
    }

    func test_case2(){
        let sr = SpacingResult(total_units: 21, number_of_events: 4,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 5)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 2)
        XCTAssertEqual(sr!.total_units(), 21)
    }

    func test_case3(){
        let sr = SpacingResult(total_units: 22, number_of_events: 4,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 6)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 22)
    }

    func test_case4(){
        let sr = SpacingResult(total_units: 23, number_of_events: 4,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 6)
        XCTAssertEqual(sr!.number_of_events, 4)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 1)
        XCTAssertEqual(sr!.total_units(), 23)
    }

 
    
    func test_corner_case1() {
        let sr = SpacingResult(total_units: 20, number_of_events: 2,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNotNil(sr!.units_between_events)
        XCTAssertEqual(sr!.units_between_events!, 18)
        XCTAssertEqual(sr!.number_of_events, 2)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 20)
        
    }

    
    func test_corner_case2() {
        let sr = SpacingResult(total_units: 20, number_of_events: 1,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 9)
        XCTAssertEqual(sr!.units_after_last_event, 9)
        XCTAssertNil(sr!.units_between_events)
        XCTAssertEqual(sr!.number_of_events, 1)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 1)
        XCTAssertEqual(sr!.total_units(), 20)
        
    }

    func test_corner_case3() {
        let sr = SpacingResult(total_units: 20, number_of_events: 1,
            units_per_event: 1, interval_before_first_event: 0.0,
            interval_after_last_event: 0.5)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 0)
        XCTAssertEqual(sr!.units_after_last_event, 19)
        XCTAssertNil(sr!.units_between_events)
        XCTAssertEqual(sr!.number_of_events, 1)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 20)
        
    }
    
    func test_corner_case4() {
        let sr = SpacingResult(total_units: 20, number_of_events: 1,
            units_per_event: 1, interval_before_first_event: 0.1,
            interval_after_last_event: 0.0)
        XCTAssertNotNil(sr)
        XCTAssertEqual(sr!.units_before_first_event, 19)
        XCTAssertEqual(sr!.units_after_last_event, 0)
        XCTAssertNil(sr!.units_between_events)
        XCTAssertEqual(sr!.number_of_events, 1)
        XCTAssertEqual(sr!.units_per_event, 1)
        XCTAssertEqual(sr!.extra_units, 0)
        XCTAssertEqual(sr!.total_units(), 20)
        
    }
    
    

}



class SpacingResultTestsBad: XCTestCase {
    
    
    func test_bad_case1(){
        let sr = SpacingResult(total_units: 3, number_of_events: 4, units_per_event: 1)
        XCTAssertNil(sr)
    }
    
    func test_bad_case2(){
        let sr = SpacingResult(total_units: 0, number_of_events: 4, units_per_event: 1)
        XCTAssertNil(sr)
    }

    func test_bad_case3(){
        let sr = SpacingResult(total_units: 3, number_of_events: 0, units_per_event: 1)
        XCTAssertNil(sr)
    }

    func test_bad_case4(){
        let sr = SpacingResult(total_units: 3, number_of_events: 1, units_per_event: 0)
        XCTAssertNil(sr)
    }
    
    func test_bad_case5(){
        let sr = SpacingResult(total_units: 10, number_of_events: 2, units_per_event: 1,
            interval_before_first_event: -0.1)
        XCTAssertNil(sr)
    }
    
    func test_bad_case6(){
        let sr = SpacingResult(total_units: 10, number_of_events: 2, units_per_event: 0,
            interval_after_last_event: -0.1)
        XCTAssertNil(sr)
    }
    
    func test_bad_case7(){
        let sr = SpacingResult(total_units: 10, number_of_events: 4, units_per_event: 3)
        XCTAssertNil(sr)
    }
    
    
}