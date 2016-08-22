//
//  RatingViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/18.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class RatingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUI() {
        super.setUI()
        
        let ratingView = YHRatingControl()
        ratingView.frame = CGRect(x: 20, y: 120, width: 120, height: 20)
        ratingView.rating = 0
        ratingView.maxRating = 6
        ratingView.spacing = 8
        ratingView.rating = 2
        ratingView.filledStarImage = UIImage(named: "star_selected")
        ratingView.emptyStarImage = UIImage(named: "star_normal")
        self.view.addSubview(ratingView)
    }
}
