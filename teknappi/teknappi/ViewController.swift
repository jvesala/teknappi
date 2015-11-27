//
//  ViewController.swift
//  teknappi
//
//  Created by Jussi Vesala on 9.11.2015.
//  Copyright © 2015 Jussi Vesala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var phoneTextField: UILabel!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func sendContactRequest(sender: UIButton) {
        phoneTextField.text = phoneNumberField.text
    }
}

