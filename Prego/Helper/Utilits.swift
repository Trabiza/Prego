//
//  Utilits.swift
//  Prego
//
//  Created by owner on 8/20/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

public class Utilits {
    
    static func textFieldStyle(textField: UITextField, imageName: String){
        textField.layer.cornerRadius = 22
        textField.layer.borderColor = AppColorsManager.orangeColor?.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(10)

        if !imageName.isEmpty {
            textField.setIcon(UIImage(named: imageName)!)
        }
    }
    
    static func textFieldStyle(textField: UITextField, imageName: String, borderColor: UIColor){
        textField.layer.cornerRadius = 22
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(10)
        
        if !imageName.isEmpty {
            textField.setIcon(UIImage(named: imageName)!)
        }
    }
    
    static func textFieldStyle(textField: UITextField){
        textField.layer.cornerRadius = 22
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(10)
    }
    
    static func cornerLeftRight(view: UIView){
        if #available(iOS 11.0, *){
            view.layer.masksToBounds = true
            view.clipsToBounds = true
            view.layer.cornerRadius = 30
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    static func currentDateTime() -> String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let interval = date.timeIntervalSince1970
        return "\(dateString) \(interval)"
    }
    
    static func getBagVC(_ vc: UIViewController) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let VC = storyBoard.instantiateViewController(withIdentifier: "BagVC") as! BagVC
        vc.addChildViewController(VC)
        return VC
    }
    
    static func englishAction(_ vc: UIViewController) {
        let mLang = DefaultManager.getLanguageDefault()
        if mLang != Config.English {
            DefaultManager.saveLanguageDefault(language: Config.English)
            
            L102Language.setAppleLAnguageTo(lang: Config.English)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            rootviewcontroller.rootViewController = vc.storyboard?.instantiateViewController(withIdentifier: "SplashVC")
            let mainwindow = (UIApplication.shared.delegate?.window!)!
            mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
            UIView.transition(with: mainwindow, duration: 0.4, animations: {}) { (finished) in
                
            }
        }
    }
    
    static func arabicActin(_ vc: UIViewController) {
        let mLang = DefaultManager.getLanguageDefault()
        if mLang != Config.Arablic {
            DefaultManager.saveLanguageDefault(language: Config.Arablic)

            L102Language.setAppleLAnguageTo(lang: Config.Arablic)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            rootviewcontroller.rootViewController = vc.storyboard?.instantiateViewController(withIdentifier: "SplashVC")
            let mainwindow = (UIApplication.shared.delegate?.window!)!
            mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
            UIView.transition(with: mainwindow, duration: 0.4, animations: {}) { (finished) in
                
            }
        }
    }
    
    static func getCurrentDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getCurrentTime() -> String{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let result = "\(hour):\(minutes)"
        
        return result
    }
}
