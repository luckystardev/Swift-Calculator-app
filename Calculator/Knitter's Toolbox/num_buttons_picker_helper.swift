//
//  number_of_buttons_data_source.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/13/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit



class NumberOfButtonsPickerHelper : NSObject, UIPickerViewDataSource  {

    // One-stop shopping for a delegate and data source for the 
    // 'Number of buttons' picker
    
    let max_buttons: Int
    
    init(max_buttons: Int) {
        assert(max_buttons > 0)
        self.max_buttons = max_buttons
    }
    
    
    // First, data-source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            return max_buttons
    }
    
    // Okay, now the delegate
    
    func pickerView(pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String! {
            return "titleForRow \(row) \(component)"
    }


    func pickerView(pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusingView view: UIView!) -> UIView {
            let return_me = UILabel()
            return_me.text = "foo"
            return return_me
    }
    
    
}