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
        print(textField.text)
    }
    
    // MARK: Actions
    @IBAction func sendContactRequest(sender: UIButton) {
        print(phoneNumberField.text)
        let response = Server.sendContactRequest(phoneNumberField.text ?? "000")
        response.subscribeNext { results in
            print(results)
        }
    }
}

