//
//  YHControl.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/19.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

@IBDesignable
public class YHPageControl: UIControl {
    @IBInspectable public var numberOfPage: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var currentPage: Int = 0 {
        didSet {
            if currentPage < 0 {
                currentPage = 0
            }
            if currentPage > numberOfPage - 1 {
                currentPage = numberOfPage - 1
            }
            if oldValue != currentPage {
                self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
            }
            setNeedsLayout()
        }
    }
    @IBInspectable public var hidesForSinglePage: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var pageIndicatorTintColor: UIColor = UIColor.clearColor() {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var currentPageIndicatorTintColor: UIColor = UIColor.clearColor() {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var pageIndicatorImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var currentIndicatorImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var spacing: Int = 9 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var imageWidth: Int = 7
    
    private var contentWidth: Int {
        return (imageWidth + spacing) * numberOfPage - spacing
    }
    private var contentView: UIView = UIView()
    
    private var imageViews = [UIImageView]()
 
    private func setUI() {
        if !contentView.isDescendantOfView(self) {
            self.addSubview(contentView)
        }
        
        let count = numberOfPage - imageViews.count
        if count > 0 {
            for _ in 0..<count {
                let imageView = UIImageView()
                imageView.contentMode = .ScaleAspectFill
                imageView.layer.cornerRadius = CGFloat(imageWidth) / 2.0
                self.imageViews.append(imageView)
                self.contentView.addSubview(imageView)
            }
        }
    }
    
    private func layoutUI() {
        contentView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: imageWidth)
        let center = CGPoint(x: self.frame.size.width / 2.0, y:self.frame.size.height / 2.0)
        contentView.center = center
        if hidesForSinglePage {
            self.contentView.hidden = numberOfPage == 1
        } else {
            self.contentView.hidden = false
        }
        var imageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth)
        for (index, imageView) in imageViews.enumerate() {
            imageFrame.origin.x = CGFloat(index * (imageWidth + spacing))
            imageView.frame = imageFrame
            imageView.layer.backgroundColor = pageIndicatorTintColor.CGColor
            imageView.image = pageIndicatorImage
        }
    }
    
    private func updateImageSelectionState() {
        let imageView = imageViews[currentPage]
        imageView.layer.backgroundColor = currentPageIndicatorTintColor.CGColor
        imageView.image = currentIndicatorImage
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.setUI()
        
        self.layoutUI()
        
        self.updateImageSelectionState()
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.handleTouches(touches, withEvent: event)
    }
    
    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.handleTouches(touches, withEvent: event)
    }
    
    private func handleTouches(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self)
            
            if position.x > (CGRectGetMaxX(contentView.frame) - CGFloat((imageWidth + spacing))) {
                self.currentPage += 1
            } else if position.x < (CGRectGetMinX(contentView.frame) + CGFloat((imageWidth + spacing))) {
                self.currentPage -= 1
            }
        }
    }
}
