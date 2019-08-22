//
//  SignUpVC.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        hideKeyboardWhenTappedAround()
        Utilits.textFieldStyle(textField: nameField, imageName: "user")
        Utilits.textFieldStyle(textField: emailField, imageName: "email")
        Utilits.textFieldStyle(textField: mobileField, imageName: "mobile")
        Utilits.textFieldStyle(textField: passwordField, imageName: "lock")
    }

}
