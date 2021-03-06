//
//  ViewController.swift
//  Horoscope
//
//  Created by Jovanny Espinal on 5/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var womanButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var checkHoroscopeButton: UIButton!
    
    let gender = MutableProperty<Bool?>(nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.layer.borderWidth = 1
        emailTextField.layer.borderWidth = 1
        cityTextField.layer.borderWidth = 1
        
        let nameSignal: RACSignal = nameTextField.rac_textSignal().map { (text) -> AnyObject! in
            return DataValidator.validName(text as! String)
        }
        
        let emailSignal: RACSignal = emailTextField.rac_textSignal().map { (text) -> AnyObject! in
            return DataValidator.validEmail(text as! String)
        }
        
        let citySignal: RACSignal = cityTextField.rac_textSignal().map { (text) -> AnyObject! in
            return DataValidator.validName(text as! String)
        }
        
        nameSignal.map { (valid) -> AnyObject! in
            return valid as! Bool ? UIColor.greenColor() : UIColor.clearColor()
        }.subscribeNext { (color) -> Void in
            self.nameTextField.layer.borderColor = (color as! UIColor).CGColor
        }
        
        emailSignal.map { (valid) -> AnyObject! in
            return valid as! Bool ? UIColor.greenColor() : UIColor.clearColor()
        }.subscribeNext {(color) -> Void in
            self.emailTextField.layer.borderColor = (color as! UIColor).CGColor
        }
        
        citySignal.map { (valid) -> AnyObject! in
            return valid as! Bool ? UIColor.greenColor() : UIColor.clearColor()
        }.subscribeNext { (color) -> Void in
            self.cityTextField.layer.borderColor = (color as! UIColor).CGColor
        }
        
        let dateSignal = datePicker.rac_signalForControlEvents(.ValueChanged).startWith(datePicker).map { (input) -> AnyObject! in
            let datePicker = input as! UIDatePicker
            
            return datePicker.date.timeIntervalSinceDate(NSDate(timeIntervalSinceNow: 0)) < 0
        }
        
        dateSignal.map { (valid) -> AnyObject! in
            return valid as! Bool ? UIColor.greenColor() : UIColor.clearColor()
        }.skip(1).subscribeNext { (color) -> Void in
            self.datePicker.layer.borderWidth = 1
            self.datePicker.layer.borderColor = (color as! UIColor).CGColor
        }
        
        let womanSignal = womanButton.rac_signalForControlEvents(.TouchUpInside).map { (signal) -> AnyObject! in
            self.gender.value = false
            
            return true
        }.startWith(false)
        
        let manSignal = manButton.rac_signalForControlEvents(.TouchUpInside).map { (signal) -> AnyObject! in
            self.gender.value = true
            
            return true
        }.startWith(false)
        
        let genderSignal = RACSignal.combineLatest([womanSignal, manSignal]).or()
        
        self.gender.producer.startWithNext { (newValue) in
            switch newValue {
            case nil:
                self.womanButton.setImage(UIImage(named: "unchecked"), forState: .Normal)
                self.manButton.setImage(UIImage(named: "unchecked"), forState: .Normal)
            case .Some(true): // Man
                self.womanButton.setImage(UIImage(named: "unchecked"), forState: .Normal)
                self.manButton.setImage(UIImage(named: "checked"), forState: .Normal)
            case .Some(false): // Woman
                self.womanButton.setImage(UIImage(named: "checked"), forState: .Normal)
                self.manButton.setImage(UIImage(named: "unchecked"), forState: .Normal)
            }
        }
        
        RACSignal.combineLatest([nameSignal, emailSignal, citySignal, dateSignal, genderSignal])
            .and().subscribeNext { (valid) -> Void in
                self.checkHoroscopeButton.enabled = valid as! Bool
            }
        
        checkHoroscopeButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (button) -> Void in
            let alertController = UIAlertController(title: "Horoscope", message: "You will have a wonderful day!", preferredStyle: .Alert)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
       
    
    }



}

