//
//  LoginView.swift
//  teknappi
//
//  Created by Jussi Vesala on 3.1.2016.
//  Copyright © 2016 Jussi Vesala. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class LoginView: UIView {
    let parent: UIView
    let image = UIImageView(image: UIImage(named: "teklogo-transparent"))
    let user = UITextField()
    let password = UITextField()
    let personIdEnd = UITextField()
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
        backgroundColor = UIColor.whiteColor()
        self.addSubview(image)

        self.addSubview(user)
        user.placeholder = "Käyttäjätunnus"
        user.rx_text.subscribeNext { value in
            self.updateButtonState()
        }.addDisposableTo(disposeBag)

        self.addSubview(password)
        password.placeholder = "Salasana"
        password.secureTextEntry = true
        password.rx_text.subscribeNext { value in
            self.updateButtonState()
        }.addDisposableTo(disposeBag)

        self.addSubview(personIdEnd)
        personIdEnd.placeholder = "Henkilötunnuksen loppuosa"
        personIdEnd.rx_text.subscribeNext { value in
            self.updateButtonState()
        }.addDisposableTo(disposeBag)

        self.addSubview(submitButton)
        submitButton.setTitle("Kirjaudu", forState: .Normal)
        submitButton.enabled = false
        submitButton.rx_tap.subscribeNext { click in
            let response = Server.sendLogin(self.user.text!, password: self.password.text!, personIdEnd: self.personIdEnd.text!)
            response.subscribeNext { results in
                print(results)
            }
        }.addDisposableTo(disposeBag)
        updateButtonState()
    }

    func updateButtonState() {
        self.submitButton.enabled = self.buttonState()
        if (self.submitButton.enabled) {
            self.submitButton.backgroundColor = UIColor.redColor()
        } else {
            self.submitButton.backgroundColor = UIColor.grayColor()
        }
    }

    func buttonState() -> Bool {
        return ((self.user.text != nil && self.user.text!.characters.count > 0) &&
            (self.password.text != nil && self.password.text!.characters.count > 0) &&
            (self.personIdEnd.text != nil && self.personIdEnd.text!.characters.count > 0))
    }

    func makeConstraints() {
        image.snp_makeConstraints{ make in
            make.top.equalTo(0).offset(20)
            make.centerX.equalTo(parent.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        user.snp_makeConstraints{ make in
            make.top.equalTo(image.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        password.snp_makeConstraints{ make in
            make.top.equalTo(user.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        personIdEnd.snp_makeConstraints{ make in
            make.top.equalTo(password.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
        }
        submitButton.snp_makeConstraints{ make in
            make.top.equalTo(personIdEnd.snp_bottom)
            make.centerX.equalTo(parent.centerXAnchor)
            make.height.equalTo(40)
            make.width.equalTo(250)
        }
    }
}