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
    
    @objc optional func carouselView(_ carouselView: YHCarouselView, selectedAtIndex: Int)
    @objc optional func carouselView(_ carouselView: YHCarouselView, index: Int, imageView: UIImageView)
}

open class YHCarouselView: UIView, UIScrollViewDelegate {
    
    open weak var delegate: YHCarouselViewDelegate?
    
    fileprivate var scrollView: UIScrollView!
    fileprivate var pageControll: UIPageControl!
    fileprivate var leftImageView: UIImageView!
    fileprivate var centerImageView: UIImageView!
    fileprivate var rightImageView: UIImageView!
    fileprivate var imageNames: [String]?
    fileprivate var currentIndex: Int = 0
    open var imageCount: Int  = 0 {
        didSet {
            self.setDefaultImage()
            DispatchQueue.main.async {
                self.perform(#selector(self.animation), with: nil, afterDelay: kCarouselViewAnimationeDelay)
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutUI()
    }
    
    // MARK: - private
    fileprivate func layoutUI() {
        let width = self.frame.width
        let height = self.frame.height
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.contentSize = CGSize(width: width * 3, height: height)
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        
        pageControll.frame = CGRect(x: 0, y: height - kCarouselViewPageControllHeight, width: width, height: kCarouselViewPageControllHeight)
        
        leftImageView.frame = CGRect(x: width * 0, y: 0, width: width, height: height)
        centerImageView.frame = CGRect(x: width * 1, y: 0, width: width, height: height)
        rightImageView.frame = CGRect(x: width * 2, y: 0, width: width, height: height)
    }
    
    fileprivate func setUI() {
        scrollView = UIScrollView.init()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentOffset = CGPoint.zero
        self.addSubview(scrollView)
        
        pageControll = UIPageControl.init()
        pageControll.pageIndicatorTintColor = UIColor.lightGray
        pageControll.currentPageIndicatorTintColor = UIColor.white
        pageControll.currentPage = currentIndex
        pageControll.isEnabled = false
        self.addSubview(pageControll)
        
        leftImageView = UIImageView.init()
        leftImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(leftImageView)
        
        centerImageView = UIImageView.init()
        centerImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(centerImageView)
        
        rightImageView = UIImageView.init()
        rightImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(rightImageView)
        
        leftImageView.image = UIImage(named: "pic_default")
        centerImageView.image = UIImage(named: "pic_default")
        rightImageView.image = UIImage(named: "pic_default")
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func tap() {
        print("点击")
        self.delegate?.carouselView?(self, selectedAtIndex: self.currentIndex)
    }
    
    @objc fileprivate func animation() {
        UIView.animate(withDuration: kCarouselViewAnimationDuration, animations: {
            let offset = self.scrollView.contentOffset
            self.scrollView.contentOffset = CGPoint(x: offset.x + self.frame.width, y: offset.y)
        }, completion: { (finished: Bool) in
            self.updateUI()
            DispatchQueue.main.async {
                self.perform(#selector(self.animation), with: nil, afterDelay: kCarouselViewAnimationeDelay)
            }
        }) 
    }
    
    fileprivate func setDefaultImage() {
        currentIndex = 0;
        scrollView.isScrollEnabled = imageCount > 0
        pageControll.isHidden = imageCount == 1
        pageControll.numberOfPages = imageCount
        let leftIndex = imageCount - 1;
        let rightIndex = (currentIndex + 1) % imageCount
        if self.imageNames == nil {
            self.requestImage(leftIndex: leftIndex, rightIndex: rightIndex)
            return
        }
        leftImageView.image = UIImage(named: imageNames![leftIndex])
        centerImageView.image = UIImage(named: imageNames![currentIndex])
        rightImageView.image = UIImage(named: imageNames![rightIndex])
    }
    
    fileprivate func reloadImage() {
        let offset = scrollView.contentOffset
        if offset.x > self.frame.width {  // 向右滑动
            currentIndex = (currentIndex + 1) % imageCount
        } else if (offset.x < self.frame.width){
            currentIndex = (currentIndex + imageCount - 1) % imageCount
        }
        let leftIndex = (currentIndex + imageCount - 1) % imageCount
        let rightIndex = (currentIndex + 1) % imageCount
        if self.imageNames == nil {
            self.requestImage(leftIndex: leftIndex, rightIndex: rightIndex)
            return
        }
        leftImageView.image = UIImage(named: imageNames![leftIndex])
        centerImageView.image = UIImage(named: imageNames![currentIndex])
        rightImageView.image = UIImage(named: imageNames![rightIndex])
    }
    
    fileprivate func requestImage(leftIndex:Int, rightIndex: Int) {
        self.delegate?.carouselView?(self, index: self.currentIndex, imageView: self.centerImageView)
        self.delegate?.carouselView?(self, index: leftIndex, imageView: self.leftImageView)
        self.delegate?.carouselView?(self, index: rightIndex, imageView: self.rightImageView)
    }
    
    fileprivate func updateUI() {
        self.reloadImage()
        
        pageControll.currentPage = currentIndex
        
        scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
    }
    
    // MARK: - UIScrollViewDelegate
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updateUI()
    }
    
    // MARK: - public
    open func loadImageNames(_ imageNames: [String]) {
        self.imageNames = imageNames
        self.imageCount = imageNames.count
    }
}
