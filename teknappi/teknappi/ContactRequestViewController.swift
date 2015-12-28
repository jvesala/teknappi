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
    let button = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(phoneNumberInput)
        view.addSubview(button)

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