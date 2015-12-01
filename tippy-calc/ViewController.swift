//
//  ViewController.swift
//  tippy-calc
//
//  Created by Andrew Yu on 11/27/15.
//  Copyright © 2015 Andrew Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var billFieldView: UIView!
    @IBOutlet weak var calcView: UIView!
    
    @IBOutlet weak var split2Label: UILabel!
    @IBOutlet weak var split3Label: UILabel!
    @IBOutlet weak var split4Label: UILabel!
    
    @IBOutlet weak var split2Symbol: UILabel!
    @IBOutlet weak var split3Symbol: UILabel!
    @IBOutlet weak var split4Symbol: UILabel!
    
    @IBOutlet weak var showMeTheMoney: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let numberFormatter = NSNumberFormatter()
    let tipPercentages = [0.18, 0.20, 0.25]
    
    
    // Return calculated vals for billAmount, tip, total all as doubles
    func calcTipAndTotal() -> (billAmount: Double, tip: Double, total:Double){
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount    = billField.text!._bridgeToObjectiveC().doubleValue
        let tip           = billAmount * tipPercentage
        let total         = billAmount + tip
        return(billAmount, tip, total)
    }

    // Set label values
    func setLabelValues(tip: Double, total: Double) {
        
        let language: String = NSLocale.preferredLanguages()[0]
        
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.locale = NSLocale(localeIdentifier: language)
        
        split2Label.text = numberFormatter.stringFromNumber(total/2)
        split3Label.text = numberFormatter.stringFromNumber(total/3)
        split4Label.text = numberFormatter.stringFromNumber(total/4)
        tipLabel.text    = numberFormatter.stringFromNumber(tip)
        totalLabel.text  = numberFormatter.stringFromNumber(total)

    }
    
    // Check dates to clear state after extended period of time
    func compareDatesAndClearState (){

        let currentLaunchDate = NSDate()
        
        // First time ever launch
        if (defaults.objectForKey("initialLaunchDate") == nil){
            let initialLaunchDate = currentLaunchDate
            defaults.setObject(initialLaunchDate, forKey: "initialLaunchDate")
        }
        else {
            // Compare intial launch dates
            let initialLaunchDate = defaults.objectForKey("initialLaunchDate") as! NSDate
            let interval = currentLaunchDate.timeIntervalSinceDate(initialLaunchDate)
            // If interval is greater than 10 minutes, billAmount is reset on NSUserDefaults
            if(interval > 600){
                defaults.removeObjectForKey("billAmount")
            }
            // Persist currentLaunchDate as the new initialLaunchDate
            defaults.setObject(currentLaunchDate,forKey: "initialLaunchDate")
        }
    }
    
    
    func setDarkColorTheme () {

        // Background colors
        self.billFieldView.backgroundColor = UIColor(red:0.16, green:0.21, blue:0.33, alpha:1.0)
        self.calcView.backgroundColor = UIColor(red:0.12, green:0.12, blue:0.15, alpha:1.0)
        
        // Tint
        self.billFieldView.tintColor = UIColor(red:0.30, green:0.39, blue:0.55, alpha:1.0)

        // Text colors
        let textColorAll = UIColor(red:0.82, green:0.88, blue:0.98, alpha:1.0)
        
        self.billField.textColor  = textColorAll
        self.tipLabel.textColor   = textColorAll
        self.totalLabel.textColor = textColorAll
        
        self.split2Label.textColor = textColorAll
        self.split3Label.textColor = textColorAll
        self.split4Label.textColor = textColorAll
        
        self.split2Symbol.textColor = textColorAll
        self.split3Symbol.textColor = textColorAll
        self.split4Symbol.textColor = textColorAll
        
        self.showMeTheMoney.textColor = textColorAll
    }
    
    func setLightColorTheme() {
        
        // Background colors
        self.billFieldView.backgroundColor = UIColor(red:0.63, green:0.84, blue:0.89, alpha:1.0)
        self.calcView.backgroundColor = UIColor(red:0.10, green:0.58, blue:0.68, alpha:1.0)

        //Tint
        self.billFieldView.tintColor = UIColor(red:0.10, green:0.58, blue:0.68, alpha:1.0)

        // Text colors
        let textColorAll = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)

        self.billField.textColor  = textColorAll
        self.tipLabel.textColor   = textColorAll
        self.totalLabel.textColor = textColorAll
        
        self.split2Label.textColor = textColorAll
        self.split3Label.textColor = textColorAll
        self.split4Label.textColor = textColorAll

        self.split2Symbol.textColor = textColorAll
        self.split3Symbol.textColor = textColorAll
        self.split4Symbol.textColor = textColorAll

        self.showMeTheMoney.textColor = textColorAll
    }
    
    func checkColorTheme () {
        let darkThemeFlag = defaults.boolForKey("darkThemeFlag")
        if darkThemeFlag {
            UIView.animateWithDuration(0.4, animations: {
                self.setDarkColorTheme()
            })
        }
        else {
            UIView.animateWithDuration(0.4, animations: {
                self.setLightColorTheme()
            })
        }
    }
    
    func checkDefaultPercentage () {
        
        // Set selectedSegmentIndex from persisted data
        if (defaults.objectForKey("tipControlIndexDefault") != nil) {
            let segmentOptToInt = defaults.integerForKey("tipControlIndexDefault")
            tipControl.selectedSegmentIndex = segmentOptToInt
            
            // Calc values and set labels
            let calculatedValues = calcTipAndTotal()
            setLabelValues(calculatedValues.tip, total: calculatedValues.total)
        }
    }
    

    /*******************************************
     * UIVIEW CONTROLLER LIFECYCLES BEGIN HERE *
     *******************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMeTheMoney.alpha = 0

        // Functions to run on load
        compareDatesAndClearState()
        checkColorTheme()

        // Grab persisted data - billField and default tip segment (selectedSegmentIndex)
        
        // Set billField values
        if (defaults.objectForKey("billAmount") != nil) {
            // Optional > NSNumber > String > set val
            let optToNum    = defaults.objectForKey("billAmount") as! NSNumber
            let numToString = "\(optToNum)"
            billField.text  = numToString
        }
        
        // Set selectedSegmentIndex from default percentage selected
        if (defaults.objectForKey("tipControlIndexDefault") != nil) {
            let segmentOptToInt = defaults.objectForKey("tipControlIndexDefault") as! Int
            tipControl.selectedSegmentIndex = segmentOptToInt
        }

        // Calculate values and set labels
        let calculatedValues = calcTipAndTotal()
        setLabelValues(calculatedValues.tip, total: calculatedValues.total)
        
        billField.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Check for color theme and default percentage when returning from Settings VC
        checkColorTheme()
        checkDefaultPercentage()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**********************
     * IBACTION FUNCTIONS *
     *********************/
    
    @IBAction func onEditingChanged(sender: AnyObject) {
    
        // Remove 0 if it is first character in the text field
        if (billField.text!.hasPrefix("0") && billField.text!.characters.count > 1) {
            billField.text = String(billField.text!.characters.dropFirst())
        }
        
        // If field is blank, fade out all attributes
        if(billField.text! == ""){
            UIView.animateWithDuration(0.4, animations: {
                self.totalLabel.alpha   = 0
                self.tipLabel.alpha     = 0
                self.tipControl.alpha   = 0
                self.split2Label.alpha  = 0
                self.split3Label.alpha  = 0
                self.split4Label.alpha  = 0
                self.split2Symbol.alpha = 0
                self.split3Symbol.alpha = 0
                self.split4Symbol.alpha = 0
            })
            UIView.animateWithDuration(0.6, animations: {
                self.showMeTheMoney.alpha = 1
            })

        }
        else {

            UIView.animateWithDuration(0.2, animations: {
                self.showMeTheMoney.alpha = 0
            })
            UIView.animateWithDuration(0.4, animations: {

                self.totalLabel.alpha   = 1
                self.tipLabel.alpha     = 1
                self.tipControl.alpha   = 1
                self.split2Label.alpha  = 1
                self.split3Label.alpha  = 1
                self.split4Label.alpha  = 1
                self.split2Symbol.alpha = 1
                self.split3Symbol.alpha = 1
                self.split4Symbol.alpha = 1
            })

        }
        
        // Calculate values and set labels
        let calculatedValues = calcTipAndTotal()
        setLabelValues(calculatedValues.tip, total: calculatedValues.total)
        
        // Persist billAmount value
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(calculatedValues.billAmount,forKey: "billAmount")
        defaults.synchronize()
    }
    
    // Close modal when Back is tapped
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

