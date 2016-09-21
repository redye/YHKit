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
let kSelectionViewAnimationDuration: TimeInterval = 0.5

@objc public protocol YHSelectionViewDelegate {
    @objc optional func seletionView(_ seletionView: YHSelectionView, didSelectedAtIndex index: Int)
}

open class YHSelectionView: UIView {

    fileprivate var selections: [String]
    fileprivate var buttons: [UIButton] = [UIButton]()
    fileprivate var indicatorLine: UIView!
    fileprivate var seperatorLine: UIView!
    fileprivate var scrollView: UIScrollView!
    fileprivate var lastSelectionIndex: Int = 0
    
    open var normalColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsLayout()
        }
    }
    open var selectedColor: UIColor = UIColor.red {
        didSet {
            setNeedsLayout()
        }
    }
    open var indicatorColor: UIColor = UIColor.red {
        didSet {
            setNeedsLayout()
        }
    }
    open var seperatorColor: UIColor = UIColor.gray {
        didSet {
            setNeedsLayout()
        }
    }
    open var normalFont: CGFloat = 13.0 {
        didSet {
            setNeedsLayout()
        }
    }
    open var selectedFont: CGFloat = 16.0 {
        didSet {
            setNeedsLayout()
        }
    }
    open var itemWidth: CGFloat = 75.0 {
        didSet {
            setNeedsLayout()
        }
    }
    weak open var delegate: YHSelectionViewDelegate?
    
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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.layoutUI()
    }
    
}

extension YHSelectionView {
    fileprivate func setUI() {
        
        scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        seperatorLine = UIView()
        self.addSubview(seperatorLine)
        
        for i in 0 ..< selections.count {
            let button = UIButton(type: .custom)
            let title = selections[i]
            button.setTitle(title, for: UIControlState())
            button.setTitle(title, for: .selected)
            button.addTarget(self, action: #selector(self.buttonClick(_:)), for: .touchUpInside)
            button.tag = kSelectionViewBaseTag + i
            self.buttons.append(button)
            self.scrollView.addSubview(button)
        }
        
        indicatorLine = UIView()
        self.scrollView.addSubview(indicatorLine)
    }
    
    fileprivate func layoutUI() {
        scrollView.frame = self.bounds
        seperatorLine.frame = CGRect(x: 0, y: self.frame.height - 0.5, width: self.frame.width, height: 0.5)
        seperatorLine.backgroundColor = seperatorColor
        
        let height = self.frame.height
        for (index, button) in buttons.enumerated() {
            button.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: height)
            button.setTitleColor(normalColor, for: UIControlState())
            button.setTitleColor(selectedColor, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: normalFont)
            if (index == self.lastSelectionIndex) {
                button.isSelected = true
                button.titleLabel?.font = UIFont.systemFont(ofSize: selectedFont)
            }
        }
        
        indicatorLine.frame = CGRect(x: itemWidth * CGFloat(self.lastSelectionIndex), y: height - kSelectionViewIndicatorLineHeight, width: itemWidth, height: kSelectionViewIndicatorLineHeight)
        indicatorLine.backgroundColor = indicatorColor
        
        scrollView.contentSize = CGSize(width: itemWidth * CGFloat(selections.count), height: height)
    }
}


extension YHSelectionView {
    @objc fileprivate func buttonClick(_ button: UIButton) {
        guard self.lastSelectionIndex != button.tag - kSelectionViewBaseTag else { return }
        
        let lastButton = buttons[self.lastSelectionIndex]
        lastButton.titleLabel?.font = UIFont.systemFont(ofSize: normalFont)
        lastButton.isSelected = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: selectedFont)
        button.isSelected = true
        self.adjustScrollViewContentOffset(button)
        let delta = fabs(CGFloat(self.lastSelectionIndex - (button.tag - kSelectionViewBaseTag)))
        if delta == 1 {
            UIView.animate(withDuration: kSelectionViewAnimationDuration, animations: {
                self.indicatorLine.center.x = button.center.x
            }) 
        } else {
            self.indicatorLine.center.x = button.center.x
        }
        self.lastSelectionIndex = button.tag - kSelectionViewBaseTag
        self.delegate?.seletionView?(self, didSelectedAtIndex: button.tag - kSelectionViewBaseTag)
        
    }
    
    fileprivate func adjustScrollViewContentOffset(_ button: UIButton) {
        if scrollView.contentSize.width == scrollView.frame.width { return }
        var offset = scrollView.contentOffset
        let position = scrollView.convert(button.frame, to: self)
        let orgin = position.origin
        let count = Int(scrollView.frame.width / itemWidth)
        if orgin.x >= itemWidth * CGFloat(count - 1) {
            offset.x += itemWidth
            if offset.x + scrollView.frame.width > scrollView.contentSize.width {
                offset.x = scrollView.contentSize.width - scrollView.frame.width
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
