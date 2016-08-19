//
//  ScrollControllViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/19.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

let kCellIdentifier = "CellIdentifier"


class ScrollControllViewController: BaseViewController {
    
    var tableView: UITableView!
    var scrollControl: YHScrollControl!
    
    override func setUI() {
        super.setUI()
        scrollControl = YHScrollControl(frame: CGRectMake(0, 64, self.view.bounds.size.width, 150))
        let imageNames = ["IMG_0010.JPG",
                          "IMG_0021.JPG",
                          "IMG_0023.JPG",
                          "IMG_0149.JPG",
                          "IMG_0151.JPG",
                          "IMG_0166.JPG"
        ]
        scrollControl.imageNames = imageNames
        self.view.addSubview(scrollControl)
        
        let frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)
        tableView = UITableView(frame: frame, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: kCellIdentifier)
        self.view.addSubview(tableView)
        let headerView = YHScrollControl(frame: CGRectMake(0, 64, self.view.bounds.size.width, 150))
        headerView.imageCount = imageNames.count
        headerView.delegate = self
        headerView.backgroundColor = UIColor.clearColor()
        headerView.hide()
        headerView.addTapGesture()
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor.clearColor()
    }
}

extension ScrollControllViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if tableView == scrollView {
            let offset = scrollView.contentOffset
            if offset.y > 0 && offset.y <= scrollControl.bounds.size.height {
                scrollControl.frame.origin.y = 64 - offset.y / 2.0
            } else if offset.y <= 0 {
                scrollControl.frame.origin.y = 64 - offset.y
            }
        }
        
    }
}


extension ScrollControllViewController: YHScrollControllDelegate {
    func scrollControll(scrollControll: YHScrollControl, offset: CGPoint) {
        scrollControl.offset = offset
    }
    
    func scrollControll(scrollControll: YHScrollControl, index: NSInteger) {
        print(index)
    }
}