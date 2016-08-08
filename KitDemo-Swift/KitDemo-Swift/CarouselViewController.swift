//
//  CarouselViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/3.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class CarouselViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setUI() {
        super.setUI()
        
        let carouselView = YHCarouselView.init(frame: CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 200))
        self.view.addSubview(carouselView)
        let imageNames = ["IMG_0010.JPG",
                          "IMG_0021.JPG",
                          "IMG_0023.JPG",
                          "IMG_0149.JPG",
                          "IMG_0151.JPG",
                          "IMG_0166.JPG"
        ]
        carouselView.loadImageNames(imageNames)
        
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 350, 375, 200))
        scrollView.backgroundColor = UIColor.orangeColor()
        scrollView.contentSize = CGSizeMake(375 * 3, 200)
        self.view.addSubview(scrollView)
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 375, 200))
        imageView.image = UIImage(named: "IMG_0010.JPG")
        imageView.contentMode = .ScaleAspectFill
        scrollView.addSubview(imageView)
    }

}
