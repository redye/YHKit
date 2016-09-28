//
//  YHWelcomeView.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/23.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

public typealias CompleteClosure = () -> Void

open class YHWelcomeView: UIView {
    lazy fileprivate var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.showsVerticalScrollIndicator = false
        temp.showsHorizontalScrollIndicator = false
        temp.isPagingEnabled = true
        temp.bounces = false
        temp.delegate = self
        return temp
    }()
    
    lazy fileprivate var pageControl: UIPageControl = {
        let temp = UIPageControl()
        temp.pageIndicatorTintColor = UIColor.lightGray
        temp.currentPageIndicatorTintColor = UIColor.white
        return temp
    }()
    
    fileprivate var imageViews = [UIImageView]()
    
    open var prefix: NSString?
    open var count: Int = 0
    
    open var complete: CompleteClosure?
    
    public init(frame: CGRect, prefix: NSString, count: Int) {
        super.init(frame: frame)
        self.prefix = prefix
        self.count = count
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    
        self.layoutUI()
    }
    
    fileprivate func layoutUI() {
        guard !self.scrollView.isDescendant(of: self) else { return }
        
        var imageFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let scale = UIScreen.main.scale
        var imageName: String = ""
        let width = self.frame.width
        let height = self.frame.height
        for i in 0 ..< self.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            self.imageViews.append(imageView)
            self.scrollView.addSubview(imageView)
            imageFrame.origin.x = self.frame.width * CGFloat(i)
            imageView.frame = imageFrame
            imageName = ""
            if scale == 3 {
                imageName = imageName.appendingFormat("%@_%iX%i_%i.jpg", prefix!, 1080, 1920, i + 1)
            } else {
                imageName = imageName.appendingFormat("%@_%iX%i_%i.jpg", prefix!, Int((width * scale)), Int((height * scale)), i + 1)
            }
            imageView.image = UIImage(named: imageName)
        }
        self.pageControl.numberOfPages = self.imageViews.count
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSize(width: width * CGFloat(self.imageViews.count), height: height)
        self.pageControl.frame = CGRect(x: 0, y: height - 50, width: width, height: 20)
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
        
        let skipButton = UIButton()
        skipButton.frame = CGRect(x: 20, y: 20, width: 50, height: 20)
        skipButton.layer.borderWidth = 1.0
        skipButton.layer.borderColor = UIColor.white.cgColor
        skipButton.layer.cornerRadius = 2.0
        skipButton.setTitle("跳过", for: UIControlState())
        skipButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        skipButton.addTarget(self, action: #selector(self.buttonClick), for: .touchUpInside)
        self.addSubview(skipButton)
        
        let nextButton = UIButton()
        let centerX = self.scrollView.contentSize.width - self.frame.width / 2.0
        nextButton.frame = CGRect(x: 20, y: self.frame.height - 90, width: 100, height: 30)
        nextButton.center.x = centerX
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.cornerRadius = 2.0
        nextButton.setTitle("立即体验", for: UIControlState())
        nextButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        nextButton.addTarget(self, action: #selector(self.buttonClick), for: .touchUpInside)
        self.scrollView.addSubview(nextButton)
    }
}


extension YHWelcomeView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let page = offset.x / scrollView.frame.width
        self.pageControl.currentPage = Int(page)
    }
}

extension YHWelcomeView {
    @objc fileprivate func buttonClick() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.alpha = 0
        }, completion: { (complete: Bool) in
            self.removeFromSuperview()
            if let complete = self.complete {
                complete()
            }

        }) 
    }
    
    public func showInView(_ containerView: UIView) {
        self.alpha = 0
 
        UIView.animate(withDuration: 0.25, animations: { 
            self.alpha = 1
        }, completion: { (complete: Bool) in
            containerView.addSubview(self)
        }) 
    }
}
