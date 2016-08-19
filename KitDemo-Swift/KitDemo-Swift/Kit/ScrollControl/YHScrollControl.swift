//
//  YHScrollControl.swift
//  TMDetailPage
//
//  Created by Hu on 16/8/19.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

@objc public protocol YHScrollControllDelegate {
    optional
    func scrollControll(scrollControll: YHScrollControl, offset: CGPoint)
    func scrollControll(scrollControll: YHScrollControl, index: NSInteger)
}

public class YHScrollControl: UIView {

    lazy private var scrollView: UIScrollView = {
        let tmp = UIScrollView()
        tmp.delegate = self
        tmp.showsVerticalScrollIndicator = false
        tmp.showsHorizontalScrollIndicator = false
        tmp.pagingEnabled = true
        return tmp
    }()
    
    lazy private var pageControl: UIPageControl = {
        let tmp = UIPageControl()
        tmp.currentPage = 0
        tmp.currentPageIndicatorTintColor = UIColor.whiteColor()
        tmp.pageIndicatorTintColor = UIColor.lightGrayColor()
        tmp.hidesForSinglePage = true
        return tmp
    }()
    
    private var imageViews = [UIImageView]()
    
    public var imageCount: Int = 0 {
        didSet {
            self.pageControl.numberOfPages = self.imageCount
            let count = self.imageCount - self.imageViews.count
            if count > 0 {
                for _ in 0 ..< count {
                    let imageView = UIImageView()
                    imageView.contentMode = .ScaleAspectFill
                    self.imageViews.append(imageView)
                    self.scrollView.addSubview(imageView)
                }
            }
        }
    }
    
    public var imageNames: [String]? {
        didSet {
            if self.imageNames != nil {
                self.imageCount = (imageNames?.count)!
                for (index, imageView) in self.imageViews.enumerate() {
                    let name = self.imageNames![index]
                    imageView.image = UIImage(named: name)
                }
            }
        }
    }
    
    public var delegate: YHScrollControllDelegate?
    
    public var offset: CGPoint = CGPointZero {
        didSet{
            self.scrollView.contentOffset = offset
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutUI()
    }
    
    private func layoutUI() {
        if !self.scrollView.isDescendantOfView(self) {
            self.addSubview(self.scrollView)
            self.addSubview(self.pageControl)
        }
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSizeMake(width * CGFloat(self.imageCount), height)
        self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)
        var x: CGFloat = 0.0
        let y: CGFloat = 0.0
        for (index, imageView) in self.imageViews.enumerate() {
            x = width * CGFloat(index)
            imageView.frame = CGRectMake(x, y, width, height)
        }
    }
}

extension YHScrollControl: UIScrollViewDelegate {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let currentPage = offset.x / scrollView.bounds.size.width
        self.pageControl.currentPage = Int(currentPage)
        
        self.delegate?.scrollControll?(self, offset: offset)
    }
}

extension YHScrollControl {
    public func hide() {
        self.pageControl.hidden = true
    }
}

extension YHScrollControl {
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTaped))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func handleTaped() {
        self.delegate?.scrollControll(self, index: self.pageControl.currentPage)
    }
}