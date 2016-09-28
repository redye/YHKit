//
//  YHScrollControl.swift
//  TMDetailPage
//
//  Created by Hu on 16/8/19.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

@objc public protocol YHScrollControllDelegate {
    @objc optional
    func scrollControll(_ scrollControll: YHScrollControl, offset: CGPoint)
    func scrollControll(_ scrollControll: YHScrollControl, index: NSInteger)
}

open class YHScrollControl: UIView {

    lazy fileprivate var scrollView: UIScrollView = {
        let tmp = UIScrollView()
        tmp.delegate = self
        tmp.showsVerticalScrollIndicator = false
        tmp.showsHorizontalScrollIndicator = false
        tmp.isPagingEnabled = true
        return tmp
    }()
    
    lazy fileprivate var pageControl: UIPageControl = {
        let tmp = UIPageControl()
        tmp.currentPage = 0
        tmp.currentPageIndicatorTintColor = UIColor.white
        tmp.pageIndicatorTintColor = UIColor.lightGray
        tmp.hidesForSinglePage = true
        return tmp
    }()
    
    fileprivate var imageViews = [UIImageView]()
    
    open var imageCount: Int = 0 {
        didSet {
            self.pageControl.numberOfPages = self.imageCount
            let count = self.imageCount - self.imageViews.count
            if count > 0 {
                for _ in 0 ..< count {
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFill
                    self.imageViews.append(imageView)
                    self.scrollView.addSubview(imageView)
                }
            }
        }
    }
    
    open var imageNames: [String]? {
        didSet {
            if self.imageNames != nil {
                self.imageCount = (imageNames?.count)!
                for (index, imageView) in self.imageViews.enumerated() {
                    let name = self.imageNames![index]
                    imageView.image = UIImage(named: name)
                }
            }
        }
    }
    
    open var delegate: YHScrollControllDelegate?
    
    open var offset: CGPoint = CGPoint.zero {
        didSet{
            self.scrollView.contentOffset = offset
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.layoutUI()
    }
    
    fileprivate func layoutUI() {
        if !self.scrollView.isDescendant(of: self) {
            self.addSubview(self.scrollView)
            self.addSubview(self.pageControl)
        }
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSize(width: width * CGFloat(self.imageCount), height: height)
        self.pageControl.frame = CGRect(x: 0, y: self.bounds.size.height - 20, width: self.bounds.size.width, height: 20)
        var x: CGFloat = 0.0
        let y: CGFloat = 0.0
        for (index, imageView) in self.imageViews.enumerated() {
            x = width * CGFloat(index)
            imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
}

extension YHScrollControl: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let currentPage = offset.x / scrollView.bounds.size.width
        self.pageControl.currentPage = Int(currentPage)
        
        self.delegate?.scrollControll?(self, offset: offset)
    }
}

extension YHScrollControl {
    public func hide() {
        self.pageControl.isHidden = true
    }
}

extension YHScrollControl {
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTaped))
        self.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func handleTaped() {
        self.delegate?.scrollControll(self, index: self.pageControl.currentPage)
    }
}
