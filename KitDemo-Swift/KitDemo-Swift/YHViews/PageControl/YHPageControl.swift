//
//  YHControl.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/19.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

@IBDesignable
open class YHPageControl: UIControl {
    @IBInspectable open var numberOfPage: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var currentPage: Int = 0 {
        didSet {
            if currentPage < 0 {
                currentPage = 0
            }
            if currentPage > numberOfPage - 1 {
                currentPage = numberOfPage - 1
            }
            if oldValue != currentPage {
                self.sendActions(for: UIControlEvents.valueChanged)
            }
            setNeedsLayout()
        }
    }
    @IBInspectable open var hidesForSinglePage: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var pageIndicatorTintColor: UIColor = UIColor.clear {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var currentPageIndicatorTintColor: UIColor = UIColor.clear {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var pageIndicatorImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var currentIndicatorImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var spacing: Int = 9 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var imageWidth: Int = 7
    
    fileprivate var contentWidth: Int {
        return (imageWidth + spacing) * numberOfPage - spacing
    }
    fileprivate var contentView: UIView = UIView()
    
    fileprivate var imageViews = [UIImageView]()
 
    fileprivate func setUI() {
        if !contentView.isDescendant(of: self) {
            self.addSubview(contentView)
        }
        
        let count = numberOfPage - imageViews.count
        if count > 0 {
            for _ in 0..<count {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = CGFloat(imageWidth) / 2.0
                self.imageViews.append(imageView)
                self.contentView.addSubview(imageView)
            }
        }
    }
    
    fileprivate func layoutUI() {
        contentView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: imageWidth)
        let center = CGPoint(x: self.frame.size.width / 2.0, y:self.frame.size.height / 2.0)
        contentView.center = center
        if hidesForSinglePage {
            self.contentView.isHidden = numberOfPage == 1
        } else {
            self.contentView.isHidden = false
        }
        var imageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth)
        for (index, imageView) in imageViews.enumerated() {
            imageFrame.origin.x = CGFloat(index * (imageWidth + spacing))
            imageView.frame = imageFrame
            imageView.layer.backgroundColor = pageIndicatorTintColor.cgColor
            imageView.image = pageIndicatorImage
        }
    }
    
    fileprivate func updateImageSelectionState() {
        let imageView = imageViews[currentPage]
        imageView.layer.backgroundColor = currentPageIndicatorTintColor.cgColor
        imageView.image = currentIndicatorImage
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.setUI()
        
        self.layoutUI()
        
        self.updateImageSelectionState()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.handleTouches(touches, withEvent: event)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.handleTouches(touches, withEvent: event)
    }
    
    fileprivate func handleTouches(_ touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            if position.x > (contentView.frame.maxX - CGFloat((imageWidth + spacing))) {
                self.currentPage += 1
            } else if position.x < (contentView.frame.minX + CGFloat((imageWidth + spacing))) {
                self.currentPage -= 1
            }
        }
    }
}
