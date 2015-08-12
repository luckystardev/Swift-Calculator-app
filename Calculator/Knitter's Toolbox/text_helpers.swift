//
//  text_helpers.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/21/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit

func makeLabelText(new_value: Int, singular_form: String, plural_form: String)
    -> String {
        // helper function to make new labels for picker rows
        var new_label_text: String
        if new_value > 1 {
            new_label_text = "\(new_value) " + plural_form
        } else {
            new_label_text = "1 " + singular_form
        }
        return new_label_text
}

func makeLabel(new_value: Int,
    singular_form: String,
    plural_form: String) -> UILabel {
        let return_me = UILabel()
        return_me.text = makeLabelText(new_value, singular_form, plural_form)
        return return_me
}

