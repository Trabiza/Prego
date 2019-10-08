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
    
    static func toLogin(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toCheckout(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "CheckOutVC") as? CheckOutVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toAddAddress(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "GoogleMapsVC") as? GoogleMapsVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toCart(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "CartVC") as? CartVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toContact(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "ContactusVC") as? ContactusVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toProfile(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toHistory(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "HistoryVC") as? HistoryVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toAbout(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutVC") as? AboutVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toAboutContent(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutContentVC") as? AboutContentVC {
            vc.present(desVC, animated: true)
        }
    }
    
    static func toNews(_ vc: UIViewController){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "NewsVC") as? NewsVC {
            vc.present(desVC, animated: true)
        }
    }
}
