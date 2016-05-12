//
//  ValidationField.swift
//  Beame
//
//  Created by Julian Hulme on 2015/10/05.
//  Copyright © 2015 ArcadeSoftware. All rights reserved.
//

import UIKit


protocol ValidatedTextFieldDelegate    {
    func validatedFieldUpdated(textField:UITextField, valid:Bool)
}

class ValidatedTextField: UITextField, UITextFieldDelegate {

    var validatedTextFieldDelegate:ValidatedTextFieldDelegate?
    var imageView:UIImageView = UIImageView()
    
    //MARK: Inherited methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.delegate = self
        //inform the delegate of the new valdiation status on load
        validatedTextFieldDelegate?.validatedFieldUpdated(self, valid: self.valid())
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        
        self.addSubview(imageView)
    }
    
    func updateUI(userEndedEditing:Bool = false) {
        
        
        if (self.valid())   {
            imageView.image = UIImage(named: "input_valid")
        }   else    {
            if (userEndedEditing)   {
                
                imageView.image = UIImage(named: "input_not_valid")
            }   else    {
                
                imageView.image = UIImage(named: "input_not_invalid_yet")
            }
        }
        
    }
    
    //This implementation of the valid() function is here to cause the build to fail, as this is a function that must be implemented by the subclass of ValidatedField. This is how Abstract classes are implemented in Swift.
    //http://bartjacobs.com/how-to-create-an-abstract-class-in-swift/
    func valid() -> Bool    {
        preconditionFailure("This method must be overridden") 
    }
    
    
    //The class will be taught about Delegates in this lecture. This will definitely be their introduction!
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //store existing position values
        let beginning = textField.beginningOfDocument
        let start = textField.positionFromPosition(beginning, offset:range.location)

        //this will be the new cursor location after insert/paste/typing
        let cursorOffset = textField.offsetFromPosition(beginning, toPosition: start!) + string.characters.count
        //update the text tot he new string
        textField.text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString:string)
        
        self.updateUI()
        
        //inform the delegate of the new valdiation status
        validatedTextFieldDelegate?.validatedFieldUpdated(self, valid: self.valid())
        
        
        //now reposition the cursor
        let newCursorPosition = textField.positionFromPosition(textField.beginningOfDocument, offset:cursorOffset)
        let newSelectedRange = textField.textRangeFromPosition(newCursorPosition!, toPosition: newCursorPosition!)
        textField.selectedTextRange = newSelectedRange
        
        
        return false // as the text has already been set above
        
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.updateUI(true)
    }
    

}
