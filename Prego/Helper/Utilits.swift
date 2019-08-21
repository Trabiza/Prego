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
    
    static func cornerLeftRight(view: UIView){
        if #available(iOS 11.0, *){
            view.layer.masksToBounds = true
            view.clipsToBounds = true
            view.layer.cornerRadius = 30
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
}
