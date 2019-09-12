//
//  LoginVC.swift
//  Prego
//
//  Created by owner on 8/20/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseMessaging
import GoogleSignIn

class LoginVC: UIViewController{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let FacebookSignInBtn = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        hideKeyboardWhenTappedAround()
        Utilits.textFieldStyle(textField: emailField, imageName: "email")
        Utilits.textFieldStyle(textField: passwordField, imageName: "lock")
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailField.text else {
            return
        }
        
        guard let password = passwordField.text else {
            return
        }
        
        if email.isEmpty {
            
            return
        }
        
        if password.isEmpty {
            
            return
        }
        
        LoginAPI.loginWithEmail(email: email, password: password, view: self.view) { (error, success) in
            if error != nil || !success {
                AlertManager.showLoginMobileFailed(on: self)
                return
            }
            NavigationManager.toHome(self)
        }
    }
}
