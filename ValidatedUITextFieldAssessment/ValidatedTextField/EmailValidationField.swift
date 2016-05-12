//
//  emailValidationField.swift
//  Beame
//
//  Created by Julian Hulme on 2015/10/02.
//  Copyright © 2015 ArcadeSoftware. All rights reserved.
//

import UIKit


class EmailValidationField: ValidatedTextField  {

    
    override func valid() -> Bool    {
        return self.validate(VALIDATION_TYPE.Email)
    }
   
}
