//
//  NavigationManager.swift
//  Prego
//
//  Created by owner on 8/19/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

public class NavigationManager {

    static func toHome(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBarVC") as? HomeTabBarVC {
            vc.present(desVC, animated: true)
        }
    }
}
