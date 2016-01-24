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
        containerView = LoginView(controller: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        selectContainerView()
        super.doLoad()
        super.viewWillAppear(animated)
    }
    
    func selectContainerView() {
        if ((UserDataRepository.getLoginToken()) != nil) {
            containerView = UserDataView(parent: scrollView)
        } else {
            containerView = LoginView(controller: self)
        }
    }
    
    func replaceView() {
        dispatch_async(dispatch_get_main_queue(), {
            for v in self.scrollView.subviews {
                v.removeFromSuperview()
            }
            self.scrollView.contentSize = CGSizeMake(self.view.bounds.width, self.containerHeight)
            self.scrollView.addSubview(self.containerView)
        })
    }
    
    func updateView() {
        selectContainerView()
        replaceView()
    }
}