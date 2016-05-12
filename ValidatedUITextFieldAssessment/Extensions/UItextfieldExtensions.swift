//
//  uitextfieldExtensinos.swift
//  Beame
//
//  Created by Julian Hulme on 2015/10/01.
//  Copyright © 2015 ArcadeSoftware. All rights reserved.
//

import Foundation
import UIKit

public enum VALIDATION_TYPE    {
    case None
    case NonEmpty
    case Pin
    case Email
    case MinLength
    case PhoneNumber
    case ExpiryDate
}

extension UITextField {


    func validate(validationType:VALIDATION_TYPE) -> Bool {
        
        let input = self.text
        if (validationType == VALIDATION_TYPE.None)    {

            return true
        } else if (validationType == VALIDATION_TYPE.NonEmpty)    {

            if (input!.isEmpty) {return false} else {return true}
            
        } else if (validationType == VALIDATION_TYPE.Email)    {

            if (self.isValidEmail(input!)) {return true} else {return false}
            
        } else if (validationType == VALIDATION_TYPE.PhoneNumber)    {
            return self.isValidPhoneNumber(input!)
        } else if (validationType == VALIDATION_TYPE.ExpiryDate)    {
            return self.isValidExpiryDate(input!)
        }
        
        return true
    }
    
    func validate(validationType:VALIDATION_TYPE, comparisonValue:String) -> Bool {
        
        let input1 = self.text
        let input2 = comparisonValue
        
        if (validationType == VALIDATION_TYPE.Pin)  {
            
            if (input1 == input2)   {
                return true
            }   else    {
                return false
            }
        }
        
        return true
    }
    
    func validate(validationType:VALIDATION_TYPE, minLength:Int) -> Bool {
        
        if (minLength <= self.text?.characters.count) {
            return true
        }   else    {
            return false
        }
    }

    func  isCardNumber(creditCardNumber:String) -> Bool {
            
        let rawCardNumber = (creditCardNumber as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
        if ((rawCardNumber as NSString).length != 16)   {
            return false
        }
        
        return true
    
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate email: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func isValidPhoneNumber(value: String) -> Bool {
        
        let PHONE_REGEX = "^[+]?[0-9]{10,13}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        let result =  phoneTest.evaluateWithObject(value)
        print ("valid phone \(result)")
        return result
        
    }
    
    
    func isValidExpiryDate(date:String) -> Bool {
        
        if ((date as NSString).length != 5)   {
            return false
        }
        let MM = (date as NSString).substringToIndex(2)
        print(MM)
        let MMInt = (MM as NSString).integerValue
        print (MMInt)
        if ((MMInt > 12) || (MMInt == 0))   {
            return false //invalid month
        }
        
        var YY = (date as NSString).substringFromIndex(3)
        var date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month], fromDate: date)
        let year = components.year
        
        let YYInt = (YY as NSString).integerValue
        print(year%100)
        if (YYInt <= year%100)   {
            if (YYInt < year%100)   {
                return false//year is in the past
            } else if (MMInt < components.month)    {
                return false //expiry date is a month previous in this year
            }
        }
        return true
    }


}