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
    let containerView2: UIView
    let containerHeight2 = CGFloat(400)
    
    init(tabBarHeight: CGFloat) {
        let scrollView = UIScrollView()
        
        print(UserDataRepository.getLoginToken())
        
        containerView2 = LoginView(parent: scrollView)
        super.init(tabBarHeight: tabBarHeight, scrollView: scrollView, containerView: containerView2, containerHeight: containerHeight2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}