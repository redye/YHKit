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

    ///这里是属性
    var classes:[AnyClass] = [AnyClass]()
    var tableView: UITableView!
    
    
    /**
     @brief 这里是方法
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        
        self.setUI()
    }
    
    func initData() {
        classes = [CarouselViewController.self,
                   WelcomeViewController.classForCoder(),
                   RatingViewController.classForCoder(),
                   ScrollControllViewController.classForCoder(),
                   PageControlViewController.classForCoder(),
                   PasswordFieldViewController.classForCoder(),
                   SelectionViewController.classForCoder()]

    }
    
    func setUI() {
        self.title = "Home"
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: kCell)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDatasource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCell, for: indexPath)
        cell.selectionStyle = .none
        let text = String(describing: self.classes[(indexPath as NSIndexPath).row])
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cls: AnyClass! = self.classes[(indexPath as NSIndexPath).row]
        let viewController = (cls as! UIViewController.Type).init()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

