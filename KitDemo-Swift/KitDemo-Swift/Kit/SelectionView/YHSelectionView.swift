//
//  YHSelectionView.swift
//  One
//
//  Created by Hu on 16/9/5.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

let kSelectionViewBaseTag = 10000
let kSelectionViewIndicatorLineHeight: CGFloat = 2.0
let kSelectionViewAnimationDuration: NSTimeInterval = 0.5

@objc public protocol YHSelectionViewDelegate {
    optional func seletionView(seletionView: YHSelectionView, didSelectedAtIndex index: Int)
}

public class YHSelectionView: UIView {

    private var selections: [String]
    private var buttons: [UIButton] = [UIButton]()
    private var indicatorLine: UIView!
    private var seperatorLine: UIView!
    private var scrollView: UIScrollView!
    private var lastSelectionIndex: Int = 0
    
    public var normalColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            setNeedsLayout()
        }
    }
    public var selectedColor: UIColor = UIColor.redColor() {
        didSet {
            setNeedsLayout()
        }
    }
    public var indicatorColor: UIColor = UIColor.redColor() {
        didSet {
            setNeedsLayout()
        }
    }
    public var seperatorColor: UIColor = UIColor.grayColor() {
        didSet {
            setNeedsLayout()
        }
    }
    public var normalFont: CGFloat = 13.0 {
        didSet {
            setNeedsLayout()
        }
    }
    public var selectedFont: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }
    public var itemWidth: CGFloat = 75.0 {
        didSet {
            setNeedsLayout()
        }
    }
    weak public var delegate: YHSelectionViewDelegate?
    
    /**
     创建
     
     - parameter frame:      frame
     - parameter selections: seletion items
     
     - returns: self
     */
    required public init(frame: CGRect, selections: [String]) {
        self.selections = selections
        super.init(frame: frame)
        self.setUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutUI()
    }
    
}

extension YHSelectionView {
    private func setUI() {
        
        scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        seperatorLine = UIView()
        self.addSubview(seperatorLine)
        
        for i in 0 ..< selections.count {
            let button = UIButton(type: .Custom)
            let title = selections[i]
            button.setTitle(title, forState: .Normal)
            button.setTitle(title, forState: .Selected)
            button.addTarget(self, action: #selector(self.buttonClick(_:)), forControlEvents: .TouchUpInside)
            button.tag = kSelectionViewBaseTag + i
            self.buttons.append(button)
            self.scrollView.addSubview(button)
        }
        
        indicatorLine = UIView()
        self.scrollView.addSubview(indicatorLine)
    }
    
    private func layoutUI() {
        scrollView.frame = self.bounds
        seperatorLine.frame = CGRect(x: 0, y: CGRectGetHeight(self.frame) - 0.5, width: CGRectGetWidth(self.frame), height: 0.5)
        seperatorLine.backgroundColor = seperatorColor
        
        let height = CGRectGetHeight(self.frame)
        for (index, button) in buttons.enumerate() {
            button.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: height)
            button.setTitleColor(normalColor, forState: .Normal)
            button.setTitleColor(selectedColor, forState: .Selected)
            button.titleLabel?.font = UIFont.systemFontOfSize(normalFont)
            if (index == self.lastSelectionIndex) {
                button.selected = true
                button.titleLabel?.font = UIFont.systemFontOfSize(selectedFont)
            }
        }
        
        indicatorLine.frame = CGRect(x: itemWidth * CGFloat(self.lastSelectionIndex), y: height - kSelectionViewIndicatorLineHeight, width: itemWidth, height: kSelectionViewIndicatorLineHeight)
        indicatorLine.backgroundColor = indicatorColor
        
        scrollView.contentSize = CGSize(width: itemWidth * CGFloat(selections.count), height: height)
    }
}


extension YHSelectionView {
    @objc private func buttonClick(button: UIButton) {
        guard self.lastSelectionIndex != button.tag - kSelectionViewBaseTag else { return }
        
        let lastButton = buttons[self.lastSelectionIndex]
        lastButton.titleLabel?.font = UIFont.systemFontOfSize(normalFont)
        lastButton.selected = false
        button.titleLabel?.font = UIFont.systemFontOfSize(selectedFont)
        button.selected = true
        self.adjustScrollViewContentOffset(button)
        let delta = fabs(CGFloat(self.lastSelectionIndex - (button.tag - kSelectionViewBaseTag)))
        if delta == 1 {
            UIView.animateWithDuration(kSelectionViewAnimationDuration) {
                self.indicatorLine.center.x = button.center.x
            }
        } else {
            self.indicatorLine.center.x = button.center.x
        }
        self.lastSelectionIndex = button.tag - kSelectionViewBaseTag
        self.delegate?.seletionView?(self, didSelectedAtIndex: button.tag - kSelectionViewBaseTag)
        
    }
    
    private func adjustScrollViewContentOffset(button: UIButton) {
        if scrollView.contentSize.width == CGRectGetWidth(scrollView.frame) { return }
        var offset = scrollView.contentOffset
        let position = scrollView.convertRect(button.frame, toView: self)
        let orgin = position.origin
        let count = Int(CGRectGetWidth(scrollView.frame) / itemWidth)
        if orgin.x >= itemWidth * CGFloat(count - 1) {
            offset.x += itemWidth
            if offset.x + CGRectGetWidth(scrollView.frame) > scrollView.contentSize.width {
                offset.x = scrollView.contentSize.width - CGRectGetWidth(scrollView.frame)
            }
        } else if orgin.x <= itemWidth {
            offset.x -= itemWidth
            if offset.x < 0 {
                offset.x = 0
            }
        }

        scrollView.setContentOffset(offset, animated: true)
    }
}