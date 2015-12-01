//
//  SettingsViewController.swift
//  tippy-calc
//
//  Created by Andrew Yu on 11/28/15.
//  Copyright © 2015 Andrew Yu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControlDefault: UISegmentedControl!
    @IBOutlet weak var colorThemeSwitch: UISwitch!

    let defaults = NSUserDefaults.standardUserDefaults()
    var darkThemeFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set switch to color flag bool value
        if (defaults.objectForKey("darkThemeFlag") != nil){
            colorThemeSwitch.on = defaults.boolForKey("darkThemeFlag")
        }
        // This check is for first time before flag val is persisted
        else {
            colorThemeSwitch.on = darkThemeFlag
        }

        // Set index for default tip percentage array
        if (defaults.objectForKey("tipControlIndexDefault") != nil) {
            let segmentOptToInt = defaults.objectForKey("tipControlIndexDefault") as! Int
            print(segmentOptToInt)
            tipControlDefault.selectedSegmentIndex = segmentOptToInt
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When value is changed on tipControlDefault, invoke setDefaultTipPercentage
    @IBAction func setDefaultTipPercentage(sender: AnyObject) {
        
        // Persist tip control index
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControlDefault.selectedSegmentIndex,forKey: "tipControlIndexDefault")
        defaults.synchronize()
    }
    
    // Close modal when Back button is pressed
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Set color theme flag
    @IBAction func colorThemeSwitchPressed(sender: UISwitch) {
        if colorThemeSwitch.on {
            defaults.setObject(true, forKey: "darkThemeFlag")
        }
        else {
            defaults.setObject(false, forKey: "darkThemeFlag")
        }
    }

}
