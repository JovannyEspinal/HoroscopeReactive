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
            .subscribeNextAs { (stepper: UIStepper) in
            self.imageHeight.constant = CGFloat(stepper.value)
        }
        
        let happinessSliderChannel = happinessSlider.rac_newValueChannelWithNilValue(0)
        let happySwitchChannel = happySwitch.rac_newOnChannel()
        
        let happyChannelTerminal = happySwitchChannel.map { (value: AnyObject!) -> AnyObject! in
            if let active = value.boolValue where active {
                return 0.75
            }
            
            return 0.25
        }
        
        happyChannelTerminal.subscribe(happinessSliderChannel)
        
        let happinessChannelTerminal = happinessSliderChannel.map { (value: AnyObject!) -> AnyObject! in
            return value != nil && value.doubleValue >= 0.5
        }
        
        happinessChannelTerminal.subscribe(happySwitchChannel)
    }
}
