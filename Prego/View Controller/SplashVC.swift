//
//  SplashVC.swift
//  Prego
//
//  Created by owner on 8/19/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if DefaultManager.getUserToken() == nil {
                //NavigationManager.toLogin(self)
                NavigationManager.toHome(self)
            }else{
                NavigationManager.toHome(self)
            }
        })
    }

}
