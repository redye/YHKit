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
        scrollControl = YHScrollControl(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 150))
        let imageNames = ["IMG_0010.JPG",
                          "IMG_0021.JPG",
                          "IMG_0023.JPG",
                          "IMG_0149.JPG",
                          "IMG_0151.JPG",
                          "IMG_0166.JPG"
        ]
        scrollControl.imageNames = imageNames
        self.view.addSubview(scrollControl)
        
        let frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64)
        tableView = UITableView(frame: frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: kCellIdentifier)
        self.view.addSubview(tableView)
        let headerView = YHScrollControl(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 150))
        headerView.imageCount = imageNames.count
        headerView.delegate = self
        headerView.backgroundColor = UIColor.clear
        headerView.hide()
        headerView.addTapGesture()
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor.clear
    }
}

extension ScrollControllViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = String((indexPath as NSIndexPath).row)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    func scrollControll(_ scrollControll: YHScrollControl, offset: CGPoint) {
        scrollControl.offset = offset
    }
    
    func scrollControll(_ scrollControll: YHScrollControl, index: NSInteger) {
        print(index)
    }
}
