//
//  ContactusVC.swift
//  Prego
//
//  Created by owner on 9/28/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class ContactusVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var mView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        hideKeyboardWhenTappedAround()
        Utilits.cornerLeftRight(view: mView)
        Utilits.textFieldStyle(textField: nameField, imageName: "user", borderColor: UIColor.lightGray)
        Utilits.textFieldStyle(textField: emailField, imageName: "email", borderColor: UIColor.lightGray)
        Utilits.textFieldStyle(textField: mobileField, imageName: "mobile", borderColor: UIColor.lightGray)
        Utilits.textFieldStyle(textField: messageField)
    }

}
