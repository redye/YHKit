//
//  PasswordFieldViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/26.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class PasswordFieldViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setUI() {
        super.setUI()
        let passwordField = YHPasswordField(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        passwordField.backgroundColor = UIColor.orange
        self.view.addSubview(passwordField)
        
        
        let textField = UITextField(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
    }

}
