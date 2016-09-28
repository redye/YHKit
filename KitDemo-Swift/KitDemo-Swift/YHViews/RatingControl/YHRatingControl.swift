//
//  YHRatingControl.swift
//  BeerTracker
//
//  Created by Hu on 16/8/16.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

@IBDesignable

open class YHRatingControl: UIView {
    // MARK: - Properties
    @IBInspectable open var rating: Int = 0 {
        didSet {
            if rating < 0 {
                rating = 0
            }
            if rating > maxRating {
                rating = maxRating
            }
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var maxRating: Int = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var filledStarImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var emptyStarImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable open var spacing: Int = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    fileprivate var ratingButtons = [UIButton]()
    fileprivate var buttonSize: Int {
        return Int(self.frame.height)
    }
    fileprivate var width: Int {
        let width = (buttonSize + spacing) * maxRating
        self.frame.size.width = CGFloat(width)
        return width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Initialization
    func initRate() {
        if ratingButtons.count == 0 {
            for _ in 0..<maxRating {
                let button = UIButton()
                button.setImage(emptyStarImage, for: UIControlState())
                button.setImage(filledStarImage, for: .selected)
                button.setImage(filledStarImage, for: [.highlighted, .selected])
                button.isUserInteractionEnabled = false
                
                button.adjustsImageWhenHighlighted = false
                ratingButtons += [button]
                addSubview(button)
            }
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.initRate()
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override open var intrinsicContentSize : CGSize {
        return CGSize(width: width, height: buttonSize)
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleStarTouches(touches, withEvent: event)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleStarTouches(touches, withEvent: event)
    }
    
    func handleStarTouches(_ touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            if position.x > -50 && position.x < CGFloat(width + 50) {
                ratingButtonSelected(position)
            }
        }
    }
    
    func ratingButtonSelected(_ position: CGPoint) {
        for (index, button) in ratingButtons.enumerated() {
            if position.x > button.frame.minX {
                self.rating = index + 1
            } else if position.x < 0 {
                self.rating = 0
            }
        }
    }
}












