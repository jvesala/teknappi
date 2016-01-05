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
    }
    
    func makeConstraints() {
        image.snp_makeConstraints{ make in
            make.top.equalTo(0).offset(20)
            make.centerX.equalTo(parent.centerXAnchor)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
}