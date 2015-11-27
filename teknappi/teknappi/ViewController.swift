//
//  ViewController.swift
//  teknappi
//
//  Created by Jussi Vesala on 9.11.2015.
//  Copyright © 2015 Jussi Vesala. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var phoneTextField: UILabel!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        phoneTextField.text = textField.text
    }
    
    // MARK: Actions
    @IBAction func sendContactRequest(sender: UIButton) {
        phoneTextField.text = phoneNumberField.text
    }
}

