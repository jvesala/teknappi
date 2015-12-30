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

class ContactRequestViewController: UIViewController, UIScrollViewDelegate {
    let scrollView = UIScrollView()
    let containerView = UIView()

    let image = UIImageView(image: UIImage(named: "teklogo-valkoinen"))
    let label = UILabel()
    let phoneNumberInput = UITextField()
    let submitButton = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(view.bounds.width, 500)

        containerView.backgroundColor = UIColor.greenColor()
        scrollView.backgroundColor = UIColor.blueColor()
        view.backgroundColor = UIColor.whiteColor()

        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        makeContainerView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSizeMake(view.bounds.width, 500)
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }

    func makeContainerView() {
        containerView.addSubview(image)
        containerView.addSubview(label)
        containerView.addSubview(phoneNumberInput)
        containerView.addSubview(submitButton)
        
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
    }
}