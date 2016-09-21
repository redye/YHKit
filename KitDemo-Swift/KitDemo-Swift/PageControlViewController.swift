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
        pageControl.frame = CGRect(x: 20, y: 120, width: 300, height: 20)
        pageControl.numberOfPage = 1
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.hidesForSinglePage = true
        pageControl.addTarget(self, action: #selector(self.valueChanged(_:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(pageControl)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 50, y: 200, width: 100, height: 30)
        button.backgroundColor = UIColor.orange
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.buttonClick), for: UIControlEvents.touchUpInside)
        
        let control = UIPageControl()
        control.frame = CGRect(x: 20, y: 250, width: 200, height: 20)
        control.numberOfPages = 10
        control.currentPage = 5
        control.pageIndicatorTintColor = UIColor.red
        control.currentPageIndicatorTintColor = UIColor.green
        control.addTarget(self, action: #selector(self.valuesChanged2(_:)), for: .valueChanged)
        self.view.addSubview(control)
    }
    
    func valuesChanged2(_ control: UIPageControl) {
        print(control.currentPage)
    }
    
    func  buttonClick() {
        pageControl.numberOfPage = 10
    }
    
    func valueChanged(_ pageControl: YHPageControl) {
        print(pageControl.currentPage)
    }
}
