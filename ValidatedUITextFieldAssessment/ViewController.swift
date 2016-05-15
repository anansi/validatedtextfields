//
//  ViewController.swift
//  ValidatedUITextFieldAssessment
//
//  Created by Julian Hulme on 2016/05/12.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var emailTextField: EmailValidationField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonTapped(sender: UIButton) {
        
        self.emailTextField.updateUI(true)
        self.emailTextField.updateUI(true)
        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }

}

