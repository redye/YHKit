//
//  YHCarouselView.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/3.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

let kCarouselViewPageControllHeight: CGFloat =  20.0
let kCarouselViewAnimationeDelay = 5.0
let kCarouselViewAnimationDuration = 0.5


@objc public protocol YHCarouselViewDelegate {
    
    optional func carouselView(carouselView: YHCarouselView, selectedAtIndex: Int)
    optional func carouselView(carouselView: YHCarouselView, showAtIndex: Int, imageView: UIImageView)
}

public class YHCarouselView: UIView, UIScrollViewDelegate {
    
    public weak var delegate: YHCarouselViewDelegate?
    
    private var scrollView: UIScrollView!
    private var pageControll: UIPageControl!
    private var leftImageView: UIImageView!
    private var centerImageView: UIImageView!
    private var rightImageView: UIImageView!
    private var imageNames: [String]?
    private var currentIndex: Int = 0
    public var imageCount: Int  = 0 {
        didSet {
            self.setDefaultImage()
//            dispatch_async(dispatch_get_main_queue()) { 
//                self.performSelector(#selector(self.animation), withObject: nil)
//            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutUI()
    }
    
    // MARK: - private
    private func layoutUI() {
        let width = CGRectGetWidth(self.frame)
        let height = CGRectGetHeight(self.frame)
        scrollView.frame = CGRectMake(0, 0, width, height)
        scrollView.contentSize = CGSizeMake(width * 3, height)
        scrollView.backgroundColor = UIColor.orangeColor()
//        scrollView.contentOffset = CGPointMake(width, 0)
        
        pageControll.frame = CGRectMake(0, height - kCarouselViewPageControllHeight, width, kCarouselViewPageControllHeight)
        
        leftImageView.frame = CGRectMake(width * 0, 0, width, height)
        centerImageView.frame = CGRectMake(width * 1, 0, width, height)
        rightImageView.frame = CGRectMake(width * 2, 0, width, height)
        
        print("1----%@", String(leftImageView.frame))
        print("2----%@", String(centerImageView.frame))
        print("3----%@", String(rightImageView.frame))
    }
    
    private func setUI() {
        scrollView = UIScrollView.init()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = true
        self.addSubview(scrollView)
        
        pageControll = UIPageControl.init()
        pageControll.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControll.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControll.currentPage = currentIndex
        pageControll.enabled = false
        self.addSubview(pageControll)
        
        leftImageView = UIImageView.init()
        leftImageView.contentMode = .ScaleAspectFill
        scrollView.addSubview(leftImageView)
        
        centerImageView = UIImageView.init()
        centerImageView.contentMode = .ScaleAspectFill
        scrollView.addSubview(centerImageView)
        
        rightImageView = UIImageView.init()
        rightImageView.contentMode = .ScaleAspectFill
        scrollView.addSubview(rightImageView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func tap() {
        let sel: ()? = self.delegate?.carouselView?(self, selectedAtIndex: self.currentIndex)
        if  sel != nil {
            self.delegate!.carouselView!(self, selectedAtIndex: self.currentIndex)
        }
    }
    
    @objc private func animation() {
        UIView.animateWithDuration(kCarouselViewAnimationDuration, delay: kCarouselViewAnimationeDelay, options: UIViewAnimationOptions.CurveLinear, animations: { 
            let offset = self.scrollView.contentOffset
            self.scrollView.contentOffset = CGPointMake(offset.x + CGRectGetWidth(self.frame), offset.y)
        }) { (finished: Bool) in
            self.updateUI()
//            self.performSelectorOnMainThread(#selector(self.animation), withObject: nil, waitUntilDone: true)
        }
    }
    
    private func setDefaultImage() {
        currentIndex = 0;
        scrollView.scrollEnabled = imageCount > 0
        pageControll.hidden = imageCount == 1
        pageControll.numberOfPages = imageCount
        let leftIndex = imageCount - 1;
        let rightIndex = (currentIndex + 1) % imageCount
        leftImageView.image = UIImage(named: imageNames![leftIndex])
        centerImageView.image = UIImage(named: imageNames![currentIndex])
        rightImageView.image = UIImage(named: imageNames![rightIndex])
    }
    
    private func reloadImage() {
        let offset = scrollView.contentOffset
        if offset.x > CGRectGetWidth(self.frame) {  // 向右滑动
            currentIndex = (currentIndex + 1) % imageCount
        } else if (offset.x < CGRectGetWidth(self.frame)){
            currentIndex = (currentIndex + imageCount - 1) % imageCount
        }
        let leftIndex = (currentIndex + imageCount - 1) % imageCount
        let rightIndex = (currentIndex + 1) % imageCount
        leftImageView.image = UIImage(named: imageNames![leftIndex])
        centerImageView.image = UIImage(named: imageNames![currentIndex])
        rightImageView.image = UIImage(named: imageNames![rightIndex])
    }
    
    private func updateUI() {
        self.reloadImage()
        
        pageControll.currentPage = currentIndex
        
        scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.frame), 0), animated: false)
    }
    
    // MARK: - UIScrollViewDelegate
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.updateUI()
    }

    // MARK: - public
    public func loadImageNames(imageNames: [String]) {
        self.imageNames = imageNames
        self.imageCount = imageNames.count
    }
}
