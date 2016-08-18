//
//  RatingViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/18.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let ratingView = YHRatingControl()
        ratingView.frame = CGRect(x: 20, y: 120, width: 120, height: 20)
        ratingView.rating = 0
        ratingView.maxRating = 6
        ratingView.spacing = 8
        ratingView.filledStarImage = UIImage(named: "star_selected")
        ratingView.emptyStarImage = UIImage(named: "star_normal")
        self.view.addSubview(ratingView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
