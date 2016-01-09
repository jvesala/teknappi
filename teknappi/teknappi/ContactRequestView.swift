//
//  ContactRequestView.swift
//  teknappi
//
//  Created by Jussi Vesala on 9.1.2016.
//  Copyright © 2016 Jussi Vesala. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ContactRequestView: UIView {
    let parent: UIView
    let image = UIImageView(image: UIImage(named: "teklogo-transparent"))
    let label = UILabel()
    let phoneNumberInput = UITextField()
    let submitButton = UIButton()
    let disposeBag = DisposeBag()
    
    init(parent: UIView) {
        self.parent = parent
        super.init(frame: parent.frame)
        makeView()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        self.addSubview(image)
        self.addSubview(label)
        label.text = "Anna puhelinnumerosi ja paina nappia, niin otamme yhteyttä!"
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        self.addSubview(phoneNumberInput)
        phoneNumberInput.placeholder = "Anna puhelinnumerosi"
        phoneNumberInput.rx_text.subscribeNext { value in
            if (value.isEmpty) {
                self.submitButton.enabled = false
            }  else {
                self.submitButton.enabled = true
            }
        }.addDisposableTo(disposeBag)
        self.addSubview(submitButton)
        submitButton.setImage(UIImage(named: "red-button"), forState: .Normal)
        submitButton.setImage(UIImage(named: "red-button-disabled"), forState: .Disabled)
        submitButton.enabled = false
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
    }
    
    func makeConstraints() {
        image.snp_makeConstraints{ make in
            make.top.equalTo(0).offset(20)
            make.centerX.equalTo(parent.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        label.snp_makeConstraints{ make in
            make.top.equalTo(image.snp_bottom).offset(20)
            make.centerX.equalTo(parent.centerXAnchor)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        phoneNumberInput.snp_makeConstraints{ make in
            make.top.equalTo(label.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        submitButton.snp_makeConstraints { make in
            make.top.equalTo(phoneNumberInput.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
    }
}
