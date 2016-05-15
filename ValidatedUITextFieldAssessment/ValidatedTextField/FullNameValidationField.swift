//
//  FullNameTextField.swift
//  ValidatedUITextFieldAssessment
//
//  Created by Julian Hulme on 2016/05/15.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class FullNameValidationField: ValidatedTextField {

    
    override func valid() -> Bool    {
        return self.validate(VALIDATION_TYPE.NonEmpty)
    }
}
