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
    let scrollView: UIScrollView
    let tabBarHeight: CGFloat
    let containerView: UIView
    let containerHeight: CGFloat

    init(tabBarHeight: CGFloat, scrollView: UIScrollView, containerView: UIView, containerHeight: CGFloat) {
        self.tabBarHeight = tabBarHeight
        self.scrollView = scrollView
        self.containerView = containerView
        self.containerHeight = containerHeight
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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}