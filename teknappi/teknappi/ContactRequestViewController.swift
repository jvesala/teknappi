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

class ContactRequestViewController: CommonViewController {
    
    init(tabBarHeight: CGFloat) {
        super.init()
        self.tabBarHeight = tabBarHeight
        containerHeight = CGFloat(400)
        containerView = ContactRequestView(parent: scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}