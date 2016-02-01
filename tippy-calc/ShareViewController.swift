//
//  ShareViewController.swift
//  tippy-calc
//
//  Created by Andrew Yu on 1/26/16.
//  Copyright © 2016 Andrew Yu. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet var shareBackgroundView: UIView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func setDarkColorTheme () {
        
        // Background colors
        self.shareBackgroundView.backgroundColor = UIColor(red:0.16, green:0.21, blue:0.33, alpha:1.0)
    }
    
    func setLightColorTheme() {
        
        // Background colors
        self.shareBackgroundView.backgroundColor = UIColor(red:0.63, green:0.84, blue:0.89, alpha:1.0)

    }
    
    
    func checkColorTheme() {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
