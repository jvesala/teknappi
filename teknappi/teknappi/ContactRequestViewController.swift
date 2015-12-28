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
    let label = UILabel()
    let phoneNumberInput = UITextField()
    let button = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1.0)
        
        view.addSubview(label)
        view.addSubview(phoneNumberInput)
        view.addSubview(button)

        label.text = "Yhteydenottopyyntö"
        label.snp_makeConstraints{ make in
            make.top.equalTo(topLayoutGuide).offset(20)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.height.equalTo(40)
        }

        phoneNumberInput.placeholder = "Anna puhelinnumerosi"
        phoneNumberInput.snp_makeConstraints{ make in
            make.top.equalTo(label.snp_bottom)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.height.equalTo(40)
        }

        button.setImage(UIImage(named: "red-button"), forState: .Normal)
        button.snp_makeConstraints { make in
            make.top.equalTo(phoneNumberInput.snp_bottom)
            make.centerX.equalTo(self.view.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        button.rx_tap.subscribeNext { click in
            print(self.phoneNumberInput.text)
            let response = Server.sendContactRequest(self.phoneNumberInput.text ?? "000")
            response.subscribeNext { results in
                print(results)
            }
        }.addDisposableTo(disposeBag)
    }    
}