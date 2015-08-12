//
//  StitchCalculatorController.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 12/27/14.
//  Copyright (c) 2014 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit


let max_gauge_inches: Float = 12.0
let min_gauge_inches: Float = 2.0

let max_length_inches: Float = 72.0
let min_length_inches: Float = 1.0

let max_stitch_count: Int = Int(ceil(max_gauge_inches * max_length_inches))
let min_stitch_count: Int = Int(floor(min_gauge_inches * min_length_inches))

let initial_gauge = Gauge(measurement_system: .Imperial, stitches_per: Measurement(float_val: 5.0)!)
let initial_length = Length(measurement: Measurement(float_val: 10.0)!, measurement_system: .Imperial)




enum Component {
    case Gauge, Length, StitchCount
}


private var _header_text_color : UIColor = UIColor.blueColor()



class StitchCalculatorController: UIViewController,
    UITableViewDataSource, UITableViewDelegate,
    UIPickerViewDataSource, UIPickerViewDelegate{

    
    
    
    @IBOutlet var stitch_calculator_table : UITableView!

    
    var gauge_cell : UITableViewCell?
    var stitch_cell : UITableViewCell?
    var length_cell : UITableViewCell?

    var gauge_picker: UIPickerView?
    var stitch_stepper: KTStepper?
    var length_picker: UIPickerView?
    
    var gauge_output: UILabel?
    var length_output: UILabel?
    var stitch_output: UILabel?
    
    var componentOrder: [Component] = [.Gauge, .StitchCount, .Length]
    
    var current_stitch_calc : StitchCalculation? = StitchCalculation(gauge: initial_gauge, length: initial_length)
    
    var gauge_picker_whole_part_options : [Int] = []
    var gauge_picker_fraction_part_options: [Fraction] = []

    var length_picker_whole_part_options: [Int] = []
    var length_picker_fraction_part_options: [Fraction] = []


    var max_stitches: Int = max_stitch_count
    var min_stitches: Int = min_stitch_count
    
// Disabling metric for now
    //let measurement_system_options = MeasurementSystem.asArray

    let measurement_system_options = [MeasurementSystem.Imperial]
    
    let row_height_fraction = 0.25
    let headers = ["what is my:", "I know my:"]
    
    // For styling programatically-created views
    var coder: NSCoder
    
    class var headerTextColor: UIColor
        {
        get { return _header_text_color }
        set {
            _header_text_color = newValue
        }
    }

    
    
    
    required init(coder aDecoder: NSCoder) {
        self.coder = aDecoder
        super.init(coder: aDecoder)

        
        gauge_picker = UIPickerView(coder: aDecoder)
        gauge_picker!.delegate = self
        gauge_picker!.dataSource = self
        gauge_output = UILabel(coder: aDecoder)
        gauge_output!.textAlignment = .Center
        gauge_cell = make_cell(gauge_picker!, output_view: gauge_output!,
            hint_text: "stitch\ngauge", coder: aDecoder)
        
        stitch_stepper = KTStepper(coder: aDecoder)
        stitch_stepper!.addTarget(self,
            action: "stitchesStepperChanged",
            forControlEvents: UIControlEvents.ValueChanged)
        stitch_output = UILabel(coder: aDecoder)
        stitch_output!.textAlignment = .Center
        stitch_cell = make_cell(stitch_stepper!, output_view: stitch_output!,
            hint_text: "total\nstitches", coder: aDecoder)
        
        
        length_picker = UIPickerView(coder: aDecoder)
        length_picker!.delegate = self
        length_picker!.dataSource = self
        length_output = UILabel(coder: aDecoder)
        length_output!.textAlignment = .Center
        length_cell = make_cell(length_picker!, output_view: length_output!,
            hint_text: "length", coder: aDecoder)
        

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        stitch_calculator_table!.canCancelContentTouches = false
//        NSLog("Gesture recognizers:")
//        if stitch_calculator_table!.gestureRecognizers == nil {
//            NSLog("No gesture recognizers")
//        } else {
//            for gr in stitch_calculator_table!.gestureRecognizers! {
//                NSLog("\(gr.description)")
//                stitch_calculator_table!.removeGestureRecognizer(gr as UIGestureRecognizer)
//            }
//        }
        
        NSLog("no more gesture recognizers")
        refreshUI()
    }

    

    
    func make_cell(input_view: UIView, output_view: UIView,
        hint_text: String, coder: NSCoder)
        -> UITableViewCell {
        
        
        let return_me = UITableViewCell(style: .Default, reuseIdentifier: nil)
        return_me.contentView.superview!.clipsToBounds = true
//        NSLog("UITableViewCell.contentView: \(return_me.contentView.description)")
//        NSLog("UITableViewCell.contentView.superview: \(return_me.contentView.superview!.description)")
            
        input_view.setTranslatesAutoresizingMaskIntoConstraints(false)
        output_view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let hint = HintLabel(coder: coder)
        hint.numberOfLines = 0
        hint.text = hint_text
        hint.sizeToFit()
        //I have no idea why this is necessary
        hint.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return_me.contentView.addSubview(input_view)
        return_me.contentView.addSubview(output_view)
        return_me.contentView.addSubview(hint)
        
        
        
        var constraintArray = Array<NSObject>()
        
        // Hint goes over on the left
        constraintArray.append(
            NSLayoutConstraint(item: hint,
                attribute: NSLayoutAttribute.LeadingMargin,
                relatedBy: NSLayoutRelation.Equal,
                toItem: return_me.contentView,
                attribute: NSLayoutAttribute.LeadingMargin,
                multiplier: 1.0,
                constant: 10))
        constraintArray.append(
            NSLayoutConstraint(item: hint,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: return_me.contentView,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 0))
        constraintArray.append(
            NSLayoutConstraint(item: hint,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: return_me.contentView,
                attribute: NSLayoutAttribute.Height,
                multiplier: 1.0,
                constant: 0))
        constraintArray.append(
            NSLayoutConstraint(item: hint,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: return_me.contentView,
                attribute: NSLayoutAttribute.Width,
                multiplier: 0.35,
                constant: 0))
        
        // Picker and output get centered vertically, stretched
        for view in [input_view, output_view] {
            constraintArray.append(
                NSLayoutConstraint(item: view,
                    attribute: NSLayoutAttribute.CenterY,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: return_me.contentView,
                    attribute: NSLayoutAttribute.CenterY,
                    multiplier: 1.0,
                    constant: 0))
            constraintArray.append(
                NSLayoutConstraint(item: view,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: return_me.contentView,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 1.0,
                    constant: 0))
            constraintArray.append(
                NSLayoutConstraint(item: view,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: return_me.contentView,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 1.0,
                    constant: 0))
            constraintArray.append(
                NSLayoutConstraint(item: view,
                    attribute: NSLayoutAttribute.LeadingMargin,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: hint,
                    attribute: NSLayoutAttribute.TrailingMargin,
                    multiplier: 1.0,
                    constant: 0))
            constraintArray.append(
                NSLayoutConstraint(item: view,
                    attribute: NSLayoutAttribute.TrailingMargin,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: return_me.contentView,
                    attribute: NSLayoutAttribute.TrailingMargin,
                    multiplier: 1.0,
                    constant: -15))
        }
        
        return_me.contentView.addConstraints(constraintArray)
            
            for view in return_me.subviews {
                if let v = view as? UIScrollView {
                    v.canCancelContentTouches = false
                }
            }
            
        return return_me

    }
    


    
    private func refreshUI(animation: Bool = true) {
        refreshGaugeCell(animation)
        refreshStitchesCell(animation)
        refreshLengthCell(animation)
        refreshTable(animation)
    }
    
    
    private func refreshGaugeCell(animation: Bool) {
        
        
        let current_gauge = current_stitch_calc!.gauge
        let output = (componentOrder[0] == .Gauge)
        

        if output {
            gauge_picker_whole_part_options = [current_gauge.stitches_per.whole_part]
            gauge_picker_fraction_part_options = [ current_gauge.stitches_per.fraction]
            
//            gauge_picker!.userInteractionEnabled = false
            
            gauge_picker!.hidden = true
            gauge_output!.hidden = false
            
        } else {
            gauge_picker_whole_part_options =
                current_stitch_calc!.make_gauge_whole_part_options(
                    min_gauge_inches,
                    max_stitches_per_inch: max_gauge_inches)
            
            gauge_picker_fraction_part_options = current_stitch_calc!.valid_fractions
//            gauge_picker!.userInteractionEnabled = true
            gauge_output!.hidden = true
            gauge_picker!.hidden = false

//            
//            if gauge_picker!.superview == nil {
//                gauge_cell!.contentView.addSubview(gauge_picker!)
//            }
//            if gauge_output!.superview === gauge_cell!.contentView  {
//                gauge_cell!.contentView.addSubview(gauge_output!)
//            }

        }
        gauge_picker!.reloadAllComponents()
        
        
        let whole_part_index = find(gauge_picker_whole_part_options,
            current_gauge.stitches_per.whole_part)!
        gauge_picker!.selectRow(whole_part_index, inComponent: 0, animated: animation)
        
        let fraction_part_index = find(gauge_picker_fraction_part_options,
            current_gauge.stitches_per.fraction)!
        gauge_picker!.selectRow(fraction_part_index, inComponent: 1, animated: animation)
        
        let measurement_system_index = find(measurement_system_options,
            current_gauge.measurement_system)!
        gauge_picker!.selectRow(measurement_system_index, inComponent: 2, animated: animation)

        gauge_output!.text = current_stitch_calc!.make_gauge_text()
        
    }
    
    

    private func refreshStitchesCell(animation: Bool) {
        
        let current_stitch_count = current_stitch_calc!.stitch_count
        let output = (componentOrder[0] == .StitchCount)

        if output {            
            stitch_output!.text = current_stitch_calc!.make_stitch_text()
            stitch_stepper!.hidden = true
            stitch_output!.hidden = false
            
        } else {
            max_stitches = current_stitch_calc!.find_max_stitches(max_stitch_count)
            min_stitches = current_stitch_calc!.find_min_stitches(min_stitch_count)
            
            stitch_stepper!.maximumValue = max_stitches
            stitch_stepper!.minimumValue = min_stitches
            stitch_stepper!.value = current_stitch_count
            stitch_stepper!.stepValue = 1
            stitch_stepper!.text = makeLabelText(current_stitch_count, "st", "sts")
            
            stitch_output!.hidden = true
            stitch_stepper!.hidden = false
            
        }
    }

    
    private func refreshLengthCell(animation: Bool) {
        
        let current_length = current_stitch_calc!.length
        let output = (componentOrder[0] == .Length)
        
        if output {
            length_picker_whole_part_options = [current_length.measurement.whole_part]
            length_picker_fraction_part_options = [current_length.measurement.fraction]
            
//            length_picker!.userInteractionEnabled = false
            length_picker!.hidden = true
            length_output!.hidden = false
            
        } else {
            length_picker_whole_part_options =
                current_stitch_calc!.make_length_whole_part_options(
                    min_length_inches,
                    max_length_inches: max_length_inches)
            
            length_picker_fraction_part_options = current_stitch_calc!.valid_fractions
//            length_picker!.userInteractionEnabled = true
            length_output!.hidden = true
            length_picker!.hidden = false
            
        }
        length_picker!.reloadAllComponents()
        
        let whole_part_index = find(length_picker_whole_part_options,
            current_length.measurement.whole_part)!
        length_picker!.selectRow(whole_part_index, inComponent: 0, animated: animation)
        
        let fraction_part_index = find(length_picker_fraction_part_options,
            current_length.measurement.fraction)!
        length_picker!.selectRow(fraction_part_index, inComponent: 1, animated: animation)
        
        let measurement_system_index = find(measurement_system_options,
            current_length.measurement_system)!
        length_picker!.selectRow(measurement_system_index, inComponent: 2, animated: animation)
        
        length_output!.text = current_stitch_calc!.make_length_text()
    }


    private func refreshTable(animation: Bool) {
        stitch_calculator_table.setEditing(true, animated: false)
        stitch_calculator_table.alwaysBounceVertical = false
        stitch_calculator_table.scrollEnabled = false
        stitch_calculator_table.tableFooterView = UIView(frame: CGRectZero)
        stitch_calculator_table.reloadData()
    }
    
    
    // 
    // helper methods
    //
    
    // Map the index path to an element in [0,1,2], going from the top down
    private func mapIndexPathToInteger(indexPath: NSIndexPath) -> Int {
        switch indexPath.section {
        case 0:
            return 0
        default:
            assert(indexPath.section == 1)
            switch indexPath.row {
            case 0:
                return 1
            default:
                assert(indexPath.section == 1)
                return 2
            }
        }
    }
    
    private func outputComponent() -> Component {
        return componentOrder[0]
    }
    

    
    //
    // Table datasource methods
    //
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        assert(tableView === self.stitch_calculator_table!)
        return 2
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            assert(tableView === self.stitch_calculator_table!)
            switch section {
            case 0:
                // Top section
                return 1
            default:
                assert(section == 1)
                return 2
            }
    }
    
    func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
            assert(tableView === self.stitch_calculator_table!)
            return headers[section]
    }

    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            assert(tableView === self.stitch_calculator_table!)
            let component = componentOrder[mapIndexPathToInteger(indexPath)]
            switch component{
            case .Gauge:
                return gauge_cell!
            case .StitchCount:
                return stitch_cell!
            case .Length:
                return length_cell!
            }
    }
    
    
    func tableView(tableView: UITableView,
        moveRowAtIndexPath fromIndexPath: NSIndexPath,
        toIndexPath: NSIndexPath) {
            assert(tableView === self.stitch_calculator_table!)
            
            let fromIndex = mapIndexPathToInteger(fromIndexPath)
            let toIndex = mapIndexPathToInteger(toIndexPath)
            
            let temp = componentOrder[toIndex]
            componentOrder[toIndex] = componentOrder[fromIndex]
            componentOrder[fromIndex] = temp
            
            refreshUI()
    }
    
    
    
    //
    // Table delegate methods
    //

    
    func tableView(tableView: UITableView,
        shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            assert(tableView === self.stitch_calculator_table!)
            return false
    }
    
    func tableView(tableView: UITableView,
        editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
            assert(tableView === self.stitch_calculator_table!)
            return .None
    }
    
//    func tableView(tableView: UITableView,
//        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//            let component = componentOrder[mapIndexPathToInteger(indexPath)]
//            var picker_height: CGFloat
//            var label_height: CGFloat
//            
//            switch component{
//            case .Gauge:
//                picker_height = CGRectGetHeight(gauge_picker!.bounds)
//                label_height = CGRectGetHeight(gauge_output!.bounds)
//            case .StitchCount:
//                picker_height = CGRectGetHeight(stitch_stepper!.bounds)
//                label_height = CGRectGetHeight(stitch_output!.bounds)
//            case .Length:
//                picker_height = CGRectGetHeight(length_picker!.bounds)
//                label_height = CGRectGetHeight(length_output!.bounds)
//            }
//            
//            if outputComponent() == component {
//                return label_height
//            } else {
//                return picker_height
//            }
//    }

    
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            
            let frame = tableView.frame
            let total_height = frame.height
            return total_height * CGFloat(row_height_fraction)
    }
    
    func tableView(tableView: UITableView,
            willDisplayHeaderView view: UIView,
        forSection section: Int) {
            
        // Styling-- headers should be centered, lower-case
            if view is UITableViewHeaderFooterView {
                let header_view = view as UITableViewHeaderFooterView
                let text_label = header_view.textLabel
                text_label.text = text_label.text!.lowercaseString
                text_label.textAlignment = .Center
                text_label.textColor = StitchCalculatorController.headerTextColor
            }
            
    }

    
    
    
    //
    // Picker datasource methods
    //

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        switch pickerView {
        case gauge_picker!:
            return numberOfGaugePickerComponents()
        case length_picker!:
            return numberOfLengthPickerComponents()
        default:
            assert(pickerView === stitch_stepper!)
            return numberOfStitchPickerComponents()
        }
    }
    
    func numberOfGaugePickerComponents() -> Int {
        return 3
    }
    
    func numberOfLengthPickerComponents() -> Int {
        return 3
    }
    
    func numberOfStitchPickerComponents() -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {

            switch pickerView {
            case gauge_picker!:
                return numberOfRowsInGaugePickerComponent(component)
            default:
                assert(pickerView === length_picker!)
                return numberOfRowsInLengthPickerComponent(component)
            }
    }
    
    
    func numberOfRowsInGaugePickerComponent(component: Int) -> Int {
        switch component {
        case 0:
            // whole part
            return gauge_picker_whole_part_options.count
        case 1:
            // fraction part
            return gauge_picker_fraction_part_options.count
        default:
            // metric vs imperial
            assert(component == 2)
            return measurement_system_options.count
        }
    }

    func numberOfRowsInLengthPickerComponent(component: Int) -> Int {
        switch component {
        case 0:
            // whole part
            return length_picker_whole_part_options.count
        case 1:
            // fraction part
            return length_picker_fraction_part_options.count
        default:
            // metric vs imperial
            assert(component == 2)
            return measurement_system_options.count
        }
    }

    
    
    //
    // Picker delegate methods
    //
    
    func pickerView(pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusingView view: UIView!) -> UIView {

            switch pickerView {
            case gauge_picker!:
                return viewForGaugePickerRow(component, row: row)
            default:
                assert(pickerView === length_picker!)
                return viewForLengthPickerRow(component, row: row)
            }
    }
    
    
    func viewForGaugePickerRow(component: Int, row: Int) -> UIView {
        switch component {
        case 0:
            // whole part
            return viewForWholePartRow(gauge_picker_whole_part_options, index: row)
        case 1:
            // fraction part
            return viewForFractionPartRow(row,
                fraction_options: gauge_picker_fraction_part_options)
        default:
            // metric vs imperial
            assert(component == 2)
            return viewForGaugePickerMeasurementSytemPartRow(row)
        }
    }
    
    func viewForLengthPickerRow(component: Int, row: Int) -> UIView {
        switch component {
        case 0:
            // whole part
            return viewForWholePartRow(length_picker_whole_part_options, index: row)
        case 1:
            // fraction part
            return viewForFractionPartRow(row,
                fraction_options: length_picker_fraction_part_options)
        default:
            // metric vs imperial
            assert(component == 2)
            return viewForLengthPickerMeasurementSytemPartRow(row)
        }
    }


    
    
    func viewForWholePartRow(option_array: [Int], index: Int) -> UILabel {
        let return_me = UILabel(coder: coder)
        let whole_part_val = option_array[index]
        return_me.text = String(whole_part_val)
        return return_me
    }
    
    func viewForFractionPartRow(fraction_index: Int, fraction_options: [Fraction]) -> UILabel {
        let return_me = UILabel(coder: coder)
        let fraction = fraction_options[fraction_index]
        return_me.text = fraction.asString()
        return return_me
    }
    
    
    func viewForGaugePickerMeasurementSytemPartRow(row: Int) -> UILabel {
        let system = measurement_system_options[row]
        let return_me = UILabel(coder: coder)
        switch system {
        case .Imperial:
            return_me.text = "/in"
        case .Metric:
            return_me.text = "/10 cm"
        }
        return return_me
    }
    
    func viewForLengthPickerMeasurementSytemPartRow(row: Int) -> UILabel {
        let system = measurement_system_options[row]
        let return_me = UILabel(coder: coder)
        switch system {
        case .Imperial:
            return_me.text = "in"
        case .Metric:
            return_me.text = "cm"
        }
        return return_me
    }
    
    
    
    
    func pickerView(pickerView: UIPickerView,
        widthForComponent component: Int) -> CGFloat {
            switch component {
            case 0:
                return 30.0
            case 1:
                return 30.0
            default:
                assert (component == 2)
                return 50.0
            }
    }
    
    
    
    
    func pickerView(pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int) {
            switch pickerView {
            case gauge_picker!:
                return didSelectGaugeRow(component, row: row, picker: pickerView)
            default:
                assert(pickerView === length_picker!)
                return didSelectLengthRow(component, row: row, picker: pickerView)
            }
    }

    
    private func currentOutputComponent() -> Component {
        return componentOrder[0]
    }
    
    
    func didSelectGaugeRow(component: Int, row: Int, picker: UIPickerView) {
        switch component {
        case 0, 1:
            let new_gauge = getNewGauge(component, row: row, picker: picker)
            if currentOutputComponent() == .Length {
                
                updateWithStitchCountAndGauge(current_stitch_calc!.stitch_count,
                        new_gauge: new_gauge)
                
            } else {
                assert(currentOutputComponent() == .StitchCount)
                UpdateWithLengthAndGauge(current_stitch_calc!.length,
                    new_gauge: new_gauge)
            }
        default:
            assert(component == 2)
            let new_measurement_system = measurement_system_options[row]
            changeMeasurementSystem(new_measurement_system)
        }
    }
    
    
    func didSelectLengthRow(component: Int, row: Int, picker: UIPickerView) {
        switch component {
        case 0, 1:
            let new_length = getNewLength(component, row: row, picker: picker)
            if currentOutputComponent() == .StitchCount {
                UpdateWithLengthAndGauge(new_length,
                    new_gauge: current_stitch_calc!.gauge)
                
            } else {
                assert(currentOutputComponent() == .Gauge)
                updateWithStitchCountAndLength(current_stitch_calc!.stitch_count,
                    new_length: new_length)
            }
        default:
            assert(component == 2)
            let new_measurement_system = measurement_system_options[row]
            changeMeasurementSystem(new_measurement_system)
        }
    }

    func stitchesStepperChanged() {
        let new_stitch_count = stitch_stepper?.value
        if currentOutputComponent() == .Length {
            updateWithStitchCountAndGauge(new_stitch_count!,
                new_gauge: current_stitch_calc!.gauge)
            
        } else {
            assert(currentOutputComponent() == .Gauge)
            updateWithStitchCountAndLength(new_stitch_count!,
                new_length: current_stitch_calc!.length)
        }
        
    }
    

    private func updateWithStitchCountAndLength(new_stitch_count: Int,
        new_length: Length) {
            
            current_stitch_calc =
                StitchCalculation(stitch_count: new_stitch_count,
                    length: new_length)
            
            refreshUI()
    }
    
    private func updateWithStitchCountAndGauge(new_stitch_count: Int,
        new_gauge: Gauge) {
            
            current_stitch_calc =
                StitchCalculation(stitch_count: new_stitch_count,
                    gauge: new_gauge)
            refreshUI()
    }

    private func UpdateWithLengthAndGauge(new_length: Length,
        new_gauge: Gauge) {
            
            current_stitch_calc = StitchCalculation(gauge: new_gauge,
                length: new_length)
            refreshUI()
    }



    
    private func _getTripleFromPicker(picker: UIPickerView, frac_options: [Fraction])
        -> (Int, Fraction, MeasurementSystem) {
        let whole_part_index = picker.selectedRowInComponent(0)
        
        let frac_part_index = picker.selectedRowInComponent(1)
        let frac_part = frac_options[frac_part_index]
        
        let ms_index = picker.selectedRowInComponent(2)
        let measurement_system = measurement_system_options[ms_index]
        
        return (whole_part_index, frac_part, measurement_system)
    }

    
    func getNewLength(component: Int, row: Int, picker: UIPickerView) -> Length {
        let triple = _getTripleFromPicker(picker,
            frac_options: length_picker_fraction_part_options)
        
        var (whole_part_index, frac_part, measurement_system) = triple
        if component == 0 {
            // use the new whole part
            whole_part_index = row
        } else {
            // use the new fraction part
            frac_part = length_picker_fraction_part_options[row]
        }
        let whole_part = length_picker_whole_part_options[whole_part_index]
        let length_val = Measurement(whole_part: whole_part, fraction: frac_part)!
        return Length(measurement: length_val, measurement_system: measurement_system)
    }

    func getNewGauge(component: Int, row: Int, picker: UIPickerView) -> Gauge {
        let triple = _getTripleFromPicker(picker,
            frac_options: gauge_picker_fraction_part_options)
        
        var (whole_part_index, frac_part, measurement_system) = triple
        if component == 0 {
            // use the new whole part
            whole_part_index = row
        } else {
            // use the new fraction part
            frac_part = gauge_picker_fraction_part_options[row]
        }
        let whole_part = gauge_picker_whole_part_options[whole_part_index]
        let stitches_per = Measurement(whole_part: whole_part, fraction: frac_part)!
        return Gauge(measurement_system: measurement_system, stitches_per: stitches_per)
    }

    
    func changeMeasurementSystem(new_measurement_system: MeasurementSystem) {
        current_stitch_calc =
            current_stitch_calc!.changeMeasurementSystem(new_measurement_system)
        refreshUI()
    }
    
    
}



