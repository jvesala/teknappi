//
//  ContactRequestViewController.swift
//  teknappi
//
//  Created by Jussi Vesala on 4.12.2015.
//  Copyright © 2015 Jussi Vesala. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ContactRequestViewController: UIViewController {
    let image = UIImageView(image: UIImage(named: "teklogo-valkoinen"))
    let label = UILabel()
    let phoneNumberInput = UITextField()
    let submitButton = UIButton()
    let loginPageLink = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(phoneNumberInput)
        view.addSubview(submitButton)
        view.addSubview(loginPageLink)

        image.snp_makeConstraints{ make in
            make.top.equalTo(topLayoutGuide).offset(20)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        label.text = "Anna puhelinnumerosi ja paina nappia, niin otamme yhteyttä!"
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.snp_makeConstraints{ make in
            make.top.equalTo(image.snp_bottom).offset(20)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }

        phoneNumberInput.placeholder = "Anna puhelinnumerosi"
        phoneNumberInput.snp_makeConstraints{ make in
            make.top.equalTo(label.snp_bottom)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.height.equalTo(40)
        }

        submitButton.setImage(UIImage(named: "red-button"), forState: .Normal)
        submitButton.setImage(UIImage(named: "red-button-disabled"), forState: .Disabled)
        submitButton.enabled = false
        submitButton.snp_makeConstraints { make in
            make.top.equalTo(phoneNumberInput.snp_bottom)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        loginPageLink.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        loginPageLink.setTitle("Siirry kirjautumissivulle", forState: UIControlState.Normal)
        loginPageLink.snp_makeConstraints { make in
            make.top.equalTo(submitButton.snp_bottom)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.height.equalTo(40)
        }
        
        phoneNumberInput.rx_text.subscribeNext { value in
            if (value.isEmpty) {
                self.submitButton.enabled = false
            }  else {
                self.submitButton.enabled = true
            }
        }.addDisposableTo(disposeBag)
        
        submitButton.rx_tap.subscribeNext { click in
            if let phoneNumber = self.phoneNumberInput.text {
                self.submitButton.enabled = false                
                self.phoneNumberInput.text? = ""
                let response = Server.sendContactRequest(phoneNumber)
                response.subscribeNext { results in
                    print(results)
                }
            }
        }.addDisposableTo(disposeBag)

        loginPageLink.rx_tap.subscribeNext { click in
            print("Login")
        }.addDisposableTo(disposeBag)
    }
}