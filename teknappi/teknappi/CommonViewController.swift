//
//  CommonViewController.swift
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

class CommonViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView
    var tabBarHeight: CGFloat
    var containerView: UIView
    var containerHeight: CGFloat

    init() {
        self.scrollView = UIScrollView()
        self.tabBarHeight = 0
        self.containerView = UIView()
        self.containerHeight = 0
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