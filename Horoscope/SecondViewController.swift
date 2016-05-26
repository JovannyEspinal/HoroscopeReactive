//
//  SecondViewController.swift
//  Horoscope
//
//  Created by Jovanny Espinal on 5/26/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var passionStepper: UIStepper!
    @IBOutlet weak var happinessSlider: UISlider!
    @IBOutlet weak var happySwitch: UISwitch!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passionStepper.rac_signalForControlEvents(.ValueChanged)
            .subscribeNext { (input: AnyObject!) in
            let stepper = input as! UIStepper
            self.imageHeight.constant = CGFloat(stepper.value)
        }
    }
}
