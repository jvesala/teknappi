//
//  UserDataViewController.swift
//  teknappi
//
//  Created by Jussi Vesala on 29.12.2015.
//  Copyright © 2015 Jussi Vesala. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class UserDataViewController: CommonViewController {

    init(tabBarHeight: CGFloat) {
        super.init()
        self.tabBarHeight = tabBarHeight
        containerHeight = CGFloat(400)
        //containerView = LoginView(parent: scrollView)
        containerView = UserDataView(parent: scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDataRepository.getLoginToken())
    }
}