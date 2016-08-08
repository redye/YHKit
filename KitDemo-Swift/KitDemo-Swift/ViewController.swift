//
//  ViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/3.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

let kCell: String = "Cell"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var classes:[AnyClass] = [AnyClass]()
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        
        self.setUI()
    }
    
    func initData() {
        classes = [CarouselViewController.classForCoder(),
                    WelcomeViewController.classForCoder()]
    }
    
    func setUI() {
        self.title = "Home"
        
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: kCell)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDatasource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCell, forIndexPath: indexPath)
        cell.selectionStyle = .None
        let text = String(self.classes[indexPath.row])
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cls: AnyClass! = self.classes[indexPath.row]
        let viewController = (cls as! UIViewController.Type).init()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

