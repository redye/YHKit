//
//  PageControlViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/22.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class PageControlViewController: BaseViewController {
    var pageControl: YHPageControl!
    
    override func setUI() {
        super.setUI()
        
        pageControl = YHPageControl()
        pageControl.frame = CGRectMake(20, 120, 300, 20)
        pageControl.numberOfPage = 5
        pageControl.currentPage = 3
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        self.view.addSubview(pageControl)
        
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(50, 200, 100, 30)
        button.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func  buttonClick() {
        pageControl.numberOfPage = 10
    }
}
