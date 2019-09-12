//
//  AlertManager.swift
//  Prego
//
//  Created by owner on 9/4/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit


public class AlertManager {
    private static func oneAction(on vc: UIViewController, mTitle: String,
                                  mActionTitle: String,mMessage: String) {
        let alert = UIAlertController(title: mTitle, message: mMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: mActionTitle, style: .cancel, handler: nil))
        vc.present(alert, animated: true)
    }
    
    static func showWrongAlert(on vc: UIViewController){
        oneAction(on: vc, mTitle: NSLocalizedString("warning", comment: "warning") , mActionTitle: NSLocalizedString("ok", comment: "ok"), mMessage: NSLocalizedString("wrong_message", comment: "wrong_message"))
    }
    
    static func showLoginMobileFailed(on vc: UIViewController){
        oneAction(on: vc, mTitle: NSLocalizedString("wrong", comment: "wrong"), mActionTitle: NSLocalizedString("ok", comment: "ok"), mMessage: NSLocalizedString("wrong_email_or_password", comment: ""))
    }
    
    static func showInvalidPassword(on vc: UIViewController){
        oneAction(on: vc, mTitle: NSLocalizedString("wrong", comment: "wrong"), mActionTitle: NSLocalizedString("submit", comment: "submit"), mMessage: NSLocalizedString("minimum_password_length", comment: ""))
    }
    
    static func showInvalidMobile(on vc: UIViewController){
        oneAction(on: vc, mTitle: NSLocalizedString("warning", comment: "warning"), mActionTitle: NSLocalizedString("submit", comment: "submit"), mMessage: NSLocalizedString("invalid_mobile", comment: ""))
    }
    
    static func showFillDataWithMessage(on vc: UIViewController, message: String){
        oneAction(on: vc, mTitle: NSLocalizedString("warning", comment: "warning"), mActionTitle: NSLocalizedString("submit", comment: "submit"),
                  mMessage: "\(message) \(NSLocalizedString("empty_data_message", comment: ""))" )
    }
    
    static func showInvalidEmail(on vc: UIViewController){
        oneAction(on: vc, mTitle: NSLocalizedString("warning", comment: "warning"), mActionTitle: NSLocalizedString("submit", comment: "submit"), mMessage: NSLocalizedString("email_input_matching", comment: ""))
    }
    
    static func showDuplicateEmail(on vc: UIViewController){
        oneAction(on: vc, mTitle: NSLocalizedString("warning", comment: "warning"), mActionTitle: NSLocalizedString("ok", comment: "ok"), mMessage: NSLocalizedString("dupicate_email", comment: "dupicate_email"))
    }
}
