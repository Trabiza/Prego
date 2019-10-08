//
//  BaseVC.swift
//  Prego
//
//  Created by owner on 10/7/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == "ar" {
            loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: self.view.subviews)
        }
    }

}
