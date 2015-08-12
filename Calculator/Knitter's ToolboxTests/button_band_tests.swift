//
//  button_band_tests.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/7/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation

import XCTest


class ButtonBandGoodTests: XCTestCase {
    
    
    func test_buttonband_basic() {
        
        let button_band = ButtonBand(total_stitches: 50 + (2*5),
            number_of_buttons: 5, stitches_per_buttonhole: 2)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 5)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 2)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 10)
        XCTAssertEqual(button_band!.number_of_buttons, 5)
        XCTAssertEqual(button_band!.final_stitches, 5)
        XCTAssertEqual(button_band!.min_stitches, 16)
        XCTAssertEqual(button_band!.max_buttonholes, 19)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 10)
        XCTAssertEqual(button_band!.total_stitches, 60)
//        XCTAssertEqual(button_band!.make_instruction_text(),
//                        "Work 5 sts, [work buttonhole over 2 sts, work 10 sts] 5 times, work 5 sts.")
    }
    
    
    func test_buttonband_huge1() {

        let button_band = ButtonBand(total_stitches: 405,
            number_of_buttons: 5, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 40)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 80)
        XCTAssertEqual(button_band!.number_of_buttons, 5)
        XCTAssertEqual(button_band!.final_stitches, 40)
        XCTAssertEqual(button_band!.min_stitches, 11)
        XCTAssertEqual(button_band!.max_buttonholes, 202)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 79)
        XCTAssertEqual(button_band!.total_stitches, 405)
    }

    
    func test_buttonband_huge2() {
        
        let button_band = ButtonBand(total_stitches: 439,
            number_of_buttons: 39, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 10)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 10)
        XCTAssertEqual(button_band!.number_of_buttons, 39)
        XCTAssertEqual(button_band!.final_stitches, 10)
        XCTAssertEqual(button_band!.min_stitches, 79)
        XCTAssertEqual(button_band!.max_buttonholes, 219)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 10)
        XCTAssertEqual(button_band!.total_stitches, 439)
    }

    
    func test_buttonband_huge3() {
        
        let button_band = ButtonBand(total_stitches: 439,
            number_of_buttons: 40, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 4)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 10)
        XCTAssertEqual(button_band!.number_of_buttons, 40)
        XCTAssertEqual(button_band!.final_stitches, 5)
        XCTAssertEqual(button_band!.min_stitches, 81)
        XCTAssertEqual(button_band!.max_buttonholes, 219)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 9)
        XCTAssertEqual(button_band!.total_stitches, 439)
    }

    func test_buttonband_minimal() {
        
        let button_band = ButtonBand(total_stitches: 19,
            number_of_buttons: 9, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 1)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 1)
        XCTAssertEqual(button_band!.number_of_buttons, 9)
        XCTAssertEqual(button_band!.final_stitches, 1)
        XCTAssertEqual(button_band!.min_stitches, 19)
        XCTAssertEqual(button_band!.max_buttonholes, 9)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 1)
        XCTAssertEqual(button_band!.total_stitches, 19)
    }
    
    
    func test_buttonband_good_1() {
        let button_band = ButtonBand(total_stitches: 18,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 1)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 4)
        XCTAssertEqual(button_band!.number_of_buttons, 4)
        XCTAssertEqual(button_band!.final_stitches, 1)
        XCTAssertEqual(button_band!.min_stitches, 9)
        XCTAssertEqual(button_band!.max_buttonholes, 8)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 3)
        XCTAssertEqual(button_band!.total_stitches, 18)
    }
    
    func test_buttonband_good_2() {
        let button_band = ButtonBand(total_stitches: 19,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 1)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 4)
        XCTAssertEqual(button_band!.number_of_buttons, 4)
        XCTAssertEqual(button_band!.final_stitches, 2)
        XCTAssertEqual(button_band!.min_stitches, 9)
        XCTAssertEqual(button_band!.max_buttonholes, 9)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 3)
        XCTAssertEqual(button_band!.total_stitches, 19)
    }
    
    func test_buttonband_good_3() {
        let button_band = ButtonBand(total_stitches: 20,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 2)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 4)
        XCTAssertEqual(button_band!.number_of_buttons, 4)
        XCTAssertEqual(button_band!.final_stitches, 2)
        XCTAssertEqual(button_band!.min_stitches, 9)
        XCTAssertEqual(button_band!.max_buttonholes, 9)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 3)
        XCTAssertEqual(button_band!.total_stitches, 20)
    }
    
    func test_buttonband_good_4() {
        let button_band = ButtonBand(total_stitches: 21,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 2)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 4)
        XCTAssertEqual(button_band!.number_of_buttons, 4)
        XCTAssertEqual(button_band!.final_stitches, 3)
        XCTAssertEqual(button_band!.min_stitches, 9)
        XCTAssertEqual(button_band!.max_buttonholes, 10)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 4)
        XCTAssertEqual(button_band!.total_stitches, 21)
    }
    
    func test_buttonband_good_5() {
        let button_band = ButtonBand(total_stitches: 22,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 3)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 4)
        XCTAssertEqual(button_band!.number_of_buttons, 4)
        XCTAssertEqual(button_band!.final_stitches, 3)
        XCTAssertEqual(button_band!.min_stitches, 9)
        XCTAssertEqual(button_band!.max_buttonholes, 10)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 4)
        XCTAssertEqual(button_band!.total_stitches, 22)
    }
    
    func test_buttonband_good_6() {
        let button_band = ButtonBand(total_stitches: 23,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 2)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 5)
        XCTAssertEqual(button_band!.number_of_buttons, 4)
        XCTAssertEqual(button_band!.final_stitches, 2)
        XCTAssertEqual(button_band!.min_stitches, 9)
        XCTAssertEqual(button_band!.max_buttonholes, 11)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 4)
        XCTAssertEqual(button_band!.total_stitches, 23)
    }
    
    
}





class ButtonBandBadTests: XCTestCase {
    
    
    func test_way_too_few_stitches() {
        
        let button_band = ButtonBand(total_stitches: 10,
            number_of_buttons: 50, stitches_per_buttonhole: 2)
        XCTAssertNil(button_band)
    }

    func test_just_too_few_stitches() {
        
        let button_band = ButtonBand(total_stitches: 10,
            number_of_buttons: 5, stitches_per_buttonhole: 1)
        XCTAssertNil(button_band)
    }

    
    func test_zero_buttons() {
        
        let button_band = ButtonBand(total_stitches: 10,
            number_of_buttons: 0, stitches_per_buttonhole: 1)
        XCTAssertNil(button_band)
    }
    
    func test_bad_input_total_stitches() {
        let button_band1 = ButtonBand(total_stitches: 0,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNil(button_band1)

        let button_band2 = ButtonBand(total_stitches: -1,
            number_of_buttons: 4, stitches_per_buttonhole: 1)
        XCTAssertNil(button_band2)

    }

    func test_bad_input_number_buttongs() {
        let button_band1 = ButtonBand(total_stitches: 23,
            number_of_buttons: 0, stitches_per_buttonhole: 1)
        XCTAssertNil(button_band1)
        
        let button_band2 = ButtonBand(total_stitches: 23,
            number_of_buttons: -1, stitches_per_buttonhole: 1)
        XCTAssertNil(button_band2)
        
    }

    func test_bad_input_stitche_per_hols() {
        let button_band1 = ButtonBand(total_stitches: 23,
            number_of_buttons: 4, stitches_per_buttonhole: 0)
        XCTAssertNil(button_band1)
        
        let button_band2 = ButtonBand(total_stitches: 23,
            number_of_buttons: 4, stitches_per_buttonhole: -1)
        XCTAssertNil(button_band2)
        
    }

}




class ButtonBandCornerCaseTests: XCTestCase {
    
    
    func test_buttonband_minimal_stitches_1() {
        
        let button_band = ButtonBand(total_stitches: 19,
            number_of_buttons: 9, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 1)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNotNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.stitches_between_buttonholes!, 1)
        XCTAssertEqual(button_band!.number_of_buttons, 9)
        XCTAssertEqual(button_band!.final_stitches, 1)
        XCTAssertEqual(button_band!.min_stitches, 19)
        XCTAssertEqual(button_band!.max_buttonholes, 9)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 1)
        XCTAssertEqual(button_band!.total_stitches, 19)
//        XCTAssertEqual(button_band!.make_instruction_text(),
//            "Work 1 st, [work buttonhole over 1 st, work 1 st] 9 times, work 1 st.")
    }
    
    func test_buttonband_minimal_stitches_2() {
        
        let button_band = ButtonBand(total_stitches: 3,
            number_of_buttons: 1, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 1)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.number_of_buttons, 1)
        XCTAssertEqual(button_band!.final_stitches, 1)
        XCTAssertEqual(button_band!.min_stitches, 3)
        XCTAssertEqual(button_band!.max_buttonholes, 1)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 1)
        XCTAssertEqual(button_band!.total_stitches, 3)
//        XCTAssertEqual(button_band!.make_instruction_text(),
//            "Work 1 st, work buttonhole over 1 st, work 1 st.")
    }
    
    func test_one_button() {
        let button_band = ButtonBand(total_stitches: 23,
            number_of_buttons: 1, stitches_per_buttonhole: 1)
        XCTAssertNotNil(button_band)
        XCTAssertEqual(button_band!.initial_stitches, 11)
        XCTAssertEqual(button_band!.stitches_per_buttonhole, 1)
        XCTAssertNil(button_band!.stitches_between_buttonholes)
        XCTAssertEqual(button_band!.number_of_buttons, 1)
        XCTAssertEqual(button_band!.final_stitches, 11)
        XCTAssertEqual(button_band!.min_stitches, 3)
        XCTAssertEqual(button_band!.max_buttonholes, 11)
        XCTAssertEqual(button_band!.max_stitches_per_hole, 21)
        XCTAssertEqual(button_band!.total_stitches, 23)
//        XCTAssertEqual(button_band!.make_instruction_text(),
//            "Work 11 sts, work buttonhole over 1 st, work 11 sts.")
    }
    
    
}
