//
//  CarouselViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/3.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class CarouselViewController: BaseViewController, YHCarouselViewDelegate {

    var imageUrls: Array<String> = [] 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setUI() {
        super.setUI()
        
        let carouselView = YHCarouselView.init(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 200))
        self.view.addSubview(carouselView)
        let imageNames = ["IMG_0010.JPG",
                          "IMG_0021.JPG",
                          "IMG_0023.JPG",
                          "IMG_0149.JPG",
                          "IMG_0151.JPG",
                          "IMG_0166.JPG"]
        carouselView.loadImageNames(imageNames)
        
        
//        let scrollView = UIScrollView(frame: CGRectMake(0, 350, 375, 200))
//        scrollView.backgroundColor = UIColor.orangeColor()
//        scrollView.contentSize = CGSizeMake(375 * 3, 200)
//        self.view.addSubview(scrollView)
//        
//        let imageView = UIImageView(frame: CGRectMake(0, 0, 375, 200))
//        imageView.image = UIImage(named: "IMG_0010.JPG")
//        imageView.contentMode = .ScaleAspectFill
//        scrollView.addSubview(imageView)
        
        imageUrls = [
                        "http://a.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40fa38bfc55a964034f79f019ec.jpg",
                        "http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyiCIYAW0AA6U_PRWkBcAALIXAL8oScADpUU566.jpg",
                        "http://dl.bizhi.sogou.com/images/2012/09/30/44928.jpg",
                        "http://dl.bizhi.sogou.com/images/2012/03/08/96703.jpg",
                        "http://image.tianjimedia.com/uploadImages/2012/010/XC4Y39BYZT9A.jpg",
                        "http://pic51.nipic.com/file/20141030/2531170_080422201000_2.jpg"
                    ]
        let carouselView2 = YHCarouselView.init(frame: CGRect(x: 0, y: 325, width: self.view.frame.width, height: 200))
        carouselView2.delegate = self
        carouselView2.imageCount = imageUrls.count
        self.view.addSubview(carouselView2)

    }
    
    // MARK: - YHCarouselViewDelegate
    func carouselView(_ carouselView: YHCarouselView, index: Int, imageView: UIImageView) {
        let url = URL(string: imageUrls[index])
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "pic_default"))
    }

}
