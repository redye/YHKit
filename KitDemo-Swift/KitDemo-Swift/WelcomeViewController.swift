//
//  WelcomeViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/8/3.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    override func setUI() {
        super.setUI()
        self.navigationController?.navigationBarHidden = true
        
        let welcomeView = YHWelcomeView(frame: self.view.bounds, prefix: "ind_upgrade", count: 5)
        welcomeView.complete = {
            print("完成")
        }
        welcomeView.showInView(self.view)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
