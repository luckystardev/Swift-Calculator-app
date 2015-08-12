//
//  shaping_result_tests.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/21/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation

import XCTest


class ShapingResultGoodTests: XCTestCase {
    
    
    func test_increase_basic() {
        let shaping_result = ShapingResult(starting_stitches: 10,
                                        ending_stitches: 14,
                                        total_rows: 10,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 2)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 2)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 4)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 2)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 2)
        XCTAssertEqual(shaping_result!.total_rows, 10)
        XCTAssertEqual(shaping_result!.ending_stitches, 14)
        
        XCTAssertEqual(shaping_result!.total_stitch_delta, 4)
        XCTAssertEqual(shaping_result!.min_total_rows, 2)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 2 rows even, work increase row, work 4 rows even, work increase row, work 2 rows even.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 34)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 0)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 30)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 0)
    
    }

    
    func test_increase_huge() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 30,
            total_rows: 100,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 2)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 4)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 9)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 5)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 10)
        XCTAssertEqual(shaping_result!.total_rows, 100)
        XCTAssertEqual(shaping_result!.ending_stitches, 30)

        XCTAssertEqual(shaping_result!.total_stitch_delta, 20)
        XCTAssertEqual(shaping_result!.min_total_rows, 10)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 4 rows even, [work increase row, work 9 rows even] 9 times, work increase row, work 5 rows even.")

    
        XCTAssertEqual(shaping_result!.max_starting_stitches, 230)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 0)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 210)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 0)
}

    
    func test_decrease_basic() {
        let shaping_result = ShapingResult(starting_stitches: 14,
            ending_stitches: 10,
            total_rows: 10,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 14)
        XCTAssertFalse(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 2)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 2)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 4)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 2)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 2)
        XCTAssertEqual(shaping_result!.total_rows, 10)
        XCTAssertEqual(shaping_result!.ending_stitches, 10)

        XCTAssertEqual(shaping_result!.total_stitch_delta, 4)
        XCTAssertEqual(shaping_result!.min_total_rows, 2)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 2 rows even, work decrease row, work 4 rows even, work decrease row, work 2 rows even.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 30)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 0)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 34)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 0)
}
    
    
    func test_decrease_huge() {
        let shaping_result = ShapingResult(starting_stitches: 30,
            ending_stitches: 10,
            total_rows: 100,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 30)
        XCTAssertFalse(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 2)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 4)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 9)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 5)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 10)
        XCTAssertEqual(shaping_result!.total_rows, 100)
        XCTAssertEqual(shaping_result!.ending_stitches, 10)

        XCTAssertEqual(shaping_result!.total_stitch_delta, 20)
        XCTAssertEqual(shaping_result!.min_total_rows, 10)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 4 rows even, [work decrease row, work 9 rows even] 9 times, work decrease row, work 5 rows even.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 210)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 0)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 230)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 0)

    }

    
    func test_increase_great_shaping() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 40,
            total_rows: 100,
            shaping_row_delta: 3,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 3)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 4)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 9)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 5)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 10)
        XCTAssertEqual(shaping_result!.total_rows, 100)

        XCTAssertEqual(shaping_result!.total_stitch_delta, 30)
        XCTAssertEqual(shaping_result!.min_total_rows, 10)
        XCTAssertEqual(shaping_result!.ending_stitches, 40)

        XCTAssertEqual(shaping_result!.max_starting_stitches, 340)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 1)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 310)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 1)
    }

    
    
    func test_decrease_great_shaping() {
        let shaping_result = ShapingResult(starting_stitches: 40,
            ending_stitches: 10,
            total_rows: 100,
            shaping_row_delta: 3,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 40)
        XCTAssertFalse(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 3)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 4)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 9)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 5)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 10)
        XCTAssertEqual(shaping_result!.total_rows, 100)

        
        XCTAssertEqual(shaping_result!.total_stitch_delta, 30)
        XCTAssertEqual(shaping_result!.min_total_rows, 10)
        XCTAssertEqual(shaping_result!.ending_stitches, 10)

        XCTAssertEqual(shaping_result!.max_starting_stitches, 310)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 1)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 340)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 1)
}

}





class ShapingResultBadTests: XCTestCase {
    
    
    func test_bad_delta() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 14,
            total_rows: 10,
            shaping_row_delta: 3,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result)
    }
    
    func test_too_few_rows_many() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 30,
            total_rows: 10,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result)
    }

    func test_too_few_rows_by_one() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 21,
            total_rows: 10,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result)
    }

    func test_no_shaping() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 10,
            total_rows: 10,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result)
    }

    
    func test_bad_input_starting_stitches() {
        let shaping_result1 = ShapingResult(starting_stitches: 0,
            ending_stitches: 14,
            total_rows: 10,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result1)

        let shaping_result2 = ShapingResult(starting_stitches: -1,
            ending_stitches: 14,
            total_rows: 10,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result2)
    }

    func test_bad_input_ending_stitches() {
        let shaping_result1 = ShapingResult(starting_stitches: 10,
            ending_stitches: 0,
            total_rows: 10,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result1)
        
        let shaping_result2 = ShapingResult(starting_stitches: 10,
            ending_stitches: -1,
            total_rows: 10,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result2)
    }

    
    func test_bad_input_total_rows() {
        let shaping_result1 = ShapingResult(starting_stitches: 10,
            ending_stitches: 14,
            total_rows: 0,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result1)
        
        let shaping_result2 = ShapingResult(starting_stitches: 10,
            ending_stitches: 14,
            total_rows: -1,
            shaping_row_delta: 2,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result2)
    }


    func test_bad_input_shaping_row_delta() {
        let shaping_result1 = ShapingResult(starting_stitches: 10,
            ending_stitches: 14,
            total_rows: 10,
            shaping_row_delta: 0,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result1)
        
        let shaping_result2 = ShapingResult(starting_stitches: 10,
            ending_stitches: 14,
            total_rows: 10,
            shaping_row_delta: -1,
            start_and_end_with_shaping_row: false)
        XCTAssertNil(shaping_result2)
    }
}




class ShapingResultCornerCaseTests: XCTestCase {

    
    func test_fewest_rows() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 20,
            total_rows: 10,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 0)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 0)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 0)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 10)
        XCTAssertEqual(shaping_result!.total_rows, 10)
        XCTAssertEqual(shaping_result!.ending_stitches, 20)

        XCTAssertEqual(shaping_result!.total_stitch_delta, 10)
        XCTAssertEqual(shaping_result!.min_total_rows, 10)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work increase row 10 times.")
        XCTAssertEqual(shaping_result!.max_starting_stitches, 30)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 10)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 20)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 0)

    }

    
    func test_one_shaping_row() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 11,
            total_rows: 10,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 4)
        XCTAssertNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 5)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 1)
        XCTAssertEqual(shaping_result!.total_rows, 10)
        XCTAssertEqual(shaping_result!.ending_stitches, 11)

        XCTAssertEqual(shaping_result!.total_stitch_delta, 1)
        XCTAssertEqual(shaping_result!.min_total_rows, 1)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 4 rows even, work increase row, work 5 rows even.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 21)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 1)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 20)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 0)

    }

    
    func test_one_shaping_row_over_one_row() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 11,
            total_rows: 1,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 0)
        XCTAssertNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 0)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 1)
        XCTAssertEqual(shaping_result!.total_rows, 1)
        XCTAssertEqual(shaping_result!.ending_stitches, 11)
        
        XCTAssertEqual(shaping_result!.total_stitch_delta, 1)
        XCTAssertEqual(shaping_result!.min_total_rows, 1)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work increase row.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 12)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 10)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 11)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 9)

    }
    
    
    func test_one_shaping_row_over_two_rows() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 11,
            total_rows: 2,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 1)
        XCTAssertNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 0)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 1)
        XCTAssertEqual(shaping_result!.total_rows, 2)
        XCTAssertEqual(shaping_result!.ending_stitches, 11)
        
        XCTAssertEqual(shaping_result!.total_stitch_delta, 1)
        XCTAssertEqual(shaping_result!.min_total_rows, 1)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 1 row even, work increase row.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 13)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 9)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 12)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 8)
    }

    
    func test_all_instructions_singular1() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 12,
            total_rows: 5,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 1)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 1)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 1)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 2)
        XCTAssertEqual(shaping_result!.total_rows, 5)
        XCTAssertEqual(shaping_result!.ending_stitches, 12)
        
        XCTAssertEqual(shaping_result!.total_stitch_delta, 2)
        XCTAssertEqual(shaping_result!.min_total_rows, 2)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 1 row even, work increase row, work 1 row even, work increase row, work 1 row even.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 17)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 7)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 15)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 5)

    }

    func test_one_row_even_multiple_times() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 14,
            total_rows: 9,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 1)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 1)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 1)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 4)
        XCTAssertEqual(shaping_result!.total_rows, 9)
        XCTAssertEqual(shaping_result!.ending_stitches, 14)
    
        XCTAssertEqual(shaping_result!.total_stitch_delta, 4)
        XCTAssertEqual(shaping_result!.min_total_rows, 4)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 1 row even, [work increase row, work 1 row even] 3 times, work increase row, work 1 row even.")

        XCTAssertEqual(shaping_result!.max_starting_stitches, 23)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 5)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 19)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 1)

    }

    func test_multiple_rows_between_two_shaping_rows() {
        let shaping_result = ShapingResult(starting_stitches: 10,
            ending_stitches: 12,
            total_rows: 9,
            shaping_row_delta: 1,
            start_and_end_with_shaping_row: false)
        XCTAssertNotNil(shaping_result)
        XCTAssertEqual(shaping_result!.starting_stitches, 10)
        XCTAssertTrue(shaping_result!.shaping_increases)
        XCTAssertEqual(shaping_result!.shaping_row_delta, 1)
        XCTAssertEqual(shaping_result!.rows_before_first_shaping_row, 1)
        XCTAssertNotNil(shaping_result!.rows_between_shaping_rows)
        XCTAssertEqual(shaping_result!.rows_between_shaping_rows!, 4)
        XCTAssertEqual(shaping_result!.rows_after_last_shaping_row, 2)
        XCTAssertEqual(shaping_result!.number_of_shaping_rows, 2)
        XCTAssertEqual(shaping_result!.total_rows, 9)
        XCTAssertEqual(shaping_result!.ending_stitches, 12)
        
        XCTAssertEqual(shaping_result!.total_stitch_delta, 2)
        XCTAssertEqual(shaping_result!.min_total_rows, 2)
//        XCTAssertEqual(shaping_result!.make_instruction_text(),
//            "Work 1 row even, work increase row, work 4 rows even, work increase row, work 2 rows even.")
        
        XCTAssertEqual(shaping_result!.max_starting_stitches, 21)
        XCTAssertEqual(shaping_result!.min_starting_stitches, 3)
        XCTAssertEqual(shaping_result!.max_ending_stitches, 19)
        XCTAssertEqual(shaping_result!.min_ending_stitches, 1)

    }

    
}





class ShapingResultEqualsTests: XCTestCase {
    
    
    
    func test_equals() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertEqual(lhs, rhs)
    }

    
    func test_not_equals1() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 2,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertNotEqual(lhs, rhs)
    }
    
    
    func test_not_equals2() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: false,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertNotEqual(lhs, rhs)
    }
    
    
    func test_not_equals3() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 2,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertNotEqual(lhs, rhs)
    }
    
    
    func test_not_equals4() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 2,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 2,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertNotEqual(lhs, rhs)
    }
    
    
    func test_not_equals5() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: nil,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertNotEqual(lhs, rhs)
    }
    
    
    func test_not_equals6() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 2,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 2,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        XCTAssertNotEqual(lhs, rhs)
    }
    
    
    
    func test_not_equals8() {
        
        let lhs: ShapingResult = ShapingResult(starting_stitches: 1,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 1,
            number_of_shaping_rows: 1)
        let rhs: ShapingResult = ShapingResult(starting_stitches: 2,
            shaping_increases: true,
            shaping_row_delta: 1,
            rows_before_first_shaping_row: 1,
            rows_between_shaping_rows: 1,
            rows_after_last_shaping_row: 2,
            number_of_shaping_rows: 2)
        XCTAssertNotEqual(lhs, rhs)
    }
    
}

