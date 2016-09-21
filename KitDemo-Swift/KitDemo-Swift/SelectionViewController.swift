//
//  SelectionViewController.swift
//  KitDemo-Swift
//
//  Created by Hu on 16/9/7.
//  Copyright © 2016年 redye. All rights reserved.
//

import UIKit

class SelectionViewController: BaseViewController {
    
    var selectionView: YHSelectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setUI() {
        super.setUI()
        let selections = ["插画", "阅读", "音乐", "电影", "音乐人", "读书", "美文"]
        selectionView = YHSelectionView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 40), selections: selections)
        selectionView.delegate = self
        self.view.addSubview(selectionView)
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 120, width: 100, height: 30)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(self.buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
    }

    func buttonClick() {
        selectionView.selectedColor = UIColor.green
        selectionView.indicatorColor = UIColor.blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SelectionViewController: YHSelectionViewDelegate {
    func seletionView(_ seletionView: YHSelectionView, didSelectedAtIndex index: Int) {
        print(index)
    }
}
