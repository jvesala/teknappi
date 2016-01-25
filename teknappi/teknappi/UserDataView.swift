//
//  UserDataView.swift
//  teknappi
//
//  Created by Jussi Vesala on 23.1.2016.
//  Copyright © 2016 Jussi Vesala. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class UserDataView: UIView {
    let parent: UIView
    let image = UIImageView(image: UIImage(named: "teklogo-transparent"))
    
    let phoneNumberLabel = UILabel()
    let phoneNumber = UITextField()
    let emailLabel = UILabel()
    let email = UITextField()
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
        let userData = UserDataRepository.getUserData()
        
        backgroundColor = UIColor.whiteColor()
        self.addSubview(image)
        
        self.addSubview(phoneNumberLabel)
        phoneNumberLabel.text = "Puhelinnumerosi"
        phoneNumber.text = userData?.phoneNumber ?? ""
        
        self.addSubview(phoneNumber)

        
        self.addSubview(emailLabel)
        emailLabel.text = "Sähköpostiosoitteesi"
        email.text = userData?.email ?? ""
        
        self.addSubview(email)
        
        self.addSubview(submitButton)
        submitButton.setTitle("Päivitä tietosi", forState: .Normal)
        submitButton.enabled = false
        updateButtonState()
    }
    
    func updateButtonState() {
        self.submitButton.backgroundColor = UIColor.grayColor()
    }

    func makeConstraints() {
        image.snp_makeConstraints{ make in
            make.top.equalTo(0).offset(20)
            make.centerX.equalTo(parent.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        phoneNumberLabel.snp_makeConstraints{ make in
            make.top.equalTo(image.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        phoneNumber.snp_makeConstraints{ make in
            make.top.equalTo(phoneNumberLabel.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        emailLabel.snp_makeConstraints{ make in
            make.top.equalTo(phoneNumber.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        email.snp_makeConstraints{ make in
            make.top.equalTo(emailLabel.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }

        submitButton.snp_makeConstraints{ make in
            make.top.equalTo(email.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
            make.width.equalTo(250)
        }
    }
}