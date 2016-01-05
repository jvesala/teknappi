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

class UserDataViewController: UIViewController, UIScrollViewDelegate {
    let tabBarHeight: CGFloat
    let scrollView = UIScrollView()
    let containerView: UIView
    let containerHeight = CGFloat(400)    
    
    init(tabBarHeight: CGFloat) {
        self.containerView = LoginView(parent: scrollView)
        self.tabBarHeight = tabBarHeight
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(view.bounds.width, containerHeight)
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height - tabBarHeight)
        scrollView.contentSize = CGSizeMake(view.bounds.width, containerHeight)
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }
}