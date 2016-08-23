//
//  YHWelcomeView.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/23.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

public typealias CompleteClosure = () -> Void

public class YHWelcomeView: UIView {
    lazy private var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.showsVerticalScrollIndicator = false
        temp.showsHorizontalScrollIndicator = false
        temp.pagingEnabled = true
        temp.bounces = false
        temp.delegate = self
        return temp
    }()
    
    lazy private var pageControl: UIPageControl = {
        let temp = UIPageControl()
        temp.pageIndicatorTintColor = UIColor.lightGrayColor()
        temp.currentPageIndicatorTintColor = UIColor.whiteColor()
        return temp
    }()
    
    private var imageViews = [UIImageView]()
    
    public var prefix: NSString?
    public var count: Int = 0
    
    public var complete: CompleteClosure?
    
    public init(frame: CGRect, prefix: NSString, count: Int) {
        super.init(frame: frame)
        self.prefix = prefix
        self.count = count
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    
        self.layoutUI()
    }
    
    private func layoutUI() {
        guard !self.scrollView.isDescendantOfView(self) else { return }
        
        var imageFrame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame))
        let scale = UIScreen.mainScreen().scale
        var imageName: String = ""
        let width = CGRectGetWidth(self.frame)
        let height = CGRectGetHeight(self.frame)
        for i in 0 ..< self.count {
            let imageView = UIImageView()
            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            self.imageViews.append(imageView)
            self.scrollView.addSubview(imageView)
            imageFrame.origin.x = CGRectGetWidth(self.frame) * CGFloat(i)
            imageView.frame = imageFrame
            imageName = ""
            if scale == 3 {
                imageName = imageName.stringByAppendingFormat("%@_%iX%i_%i.jpg", prefix!, 1080, 1920, i + 1)
            } else {
                imageName = imageName.stringByAppendingFormat("%@_%iX%i_%i.jpg", prefix!, Int((width * scale)), Int((height * scale)), i + 1)
            }
            imageView.image = UIImage(named: imageName)
        }
        self.pageControl.numberOfPages = self.imageViews.count
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSizeMake(width * CGFloat(self.imageViews.count), height)
        self.pageControl.frame = CGRect(x: 0, y: height - 50, width: width, height: 20)
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
        
        let skipButton = UIButton()
        skipButton.frame = CGRectMake(20, 20, 50, 20)
        skipButton.layer.borderWidth = 1.0
        skipButton.layer.borderColor = UIColor.whiteColor().CGColor
        skipButton.layer.cornerRadius = 2.0
        skipButton.setTitle("跳过", forState: .Normal)
        skipButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        skipButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        skipButton.addTarget(self, action: #selector(self.buttonClick), forControlEvents: .TouchUpInside)
        self.addSubview(skipButton)
        
        let nextButton = UIButton()
        let centerX = self.scrollView.contentSize.width - CGRectGetWidth(self.frame) / 2.0
        nextButton.frame = CGRectMake(20, CGRectGetHeight(self.frame) - 90, 100, 30)
        nextButton.center.x = centerX
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = UIColor.whiteColor().CGColor
        nextButton.layer.cornerRadius = 2.0
        nextButton.setTitle("立即体验", forState: .Normal)
        nextButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        nextButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        nextButton.addTarget(self, action: #selector(self.buttonClick), forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(nextButton)
    }
}


extension YHWelcomeView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let page = offset.x / CGRectGetWidth(scrollView.frame)
        self.pageControl.currentPage = Int(page)
    }
}

extension YHWelcomeView {
    @objc private func buttonClick() {
        UIView.animateWithDuration(0.25, animations: { 
            self.alpha = 0
        }) { (complete: Bool) in
            self.removeFromSuperview()
            if let complete = self.complete {
                complete()
            }

        }
    }
    
    public func showInView(containerView: UIView) {
        self.alpha = 0
 
        UIView.animateWithDuration(0.25, animations: { 
            self.alpha = 1
        }) { (complete: Bool) in
            containerView.addSubview(self)
        }
    }
}
