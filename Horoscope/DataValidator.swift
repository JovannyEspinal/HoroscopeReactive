//
//  DataValidator.swift
//  Horoscope
//
//  Created by Jovanny Espinal on 5/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

class DataValidator {
    class func validName(name: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^\\w+( \\w+\\.?)*$", options: .CaseInsensitive) {
            return name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 2 && regex.matchesInString(name, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))).count > 0
        }
        
        return false
    }
    
    class func validEmail(email: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: .CaseInsensitive) {
            return regex.matchesInString(email, options: .ReportProgress, range: NSMakeRange(0, email.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))).count > 0
        }
        
        return false
    }
}