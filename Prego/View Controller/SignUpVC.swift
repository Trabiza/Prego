//
//  SignUpVC.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        hideKeyboardWhenTappedAround()
        Utilits.textFieldStyle(textField: firstNameField, imageName: "user")
        Utilits.textFieldStyle(textField: lastNameField, imageName: "user")
        Utilits.textFieldStyle(textField: emailField, imageName: "email")
        Utilits.textFieldStyle(textField: mobileField, imageName: "mobile")
        Utilits.textFieldStyle(textField: passwordField, imageName: "lock")
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        validateData()
    }
    
    
    
    func validateData(){
        guard let firstName = firstNameField.text else {
            return
        }
        
        guard let lastName = lastNameField.text else {
            return
        }
        
        guard let email = emailField.text else {
            return
        }
        
        guard let password = passwordField.text else {
            return
        }
        
        guard let mobile = mobileField.text else {
            return
        }
        
        if !RegularExpression.isValidEmpty(text: firstName){
            AlertManager.showFillDataWithMessage(on: self, message: NSLocalizedString("firstname", comment: "firstname"))
            return
        }
        
        if !RegularExpression.isValidEmpty(text: lastName){
            AlertManager.showFillDataWithMessage(on: self, message: NSLocalizedString("lastname", comment: "lastname"))
            return
        }
        
        if !RegularExpression.isValidEmail(email: email){
            AlertManager.showInvalidEmail(on: self)
            return
        }
        
        if !RegularExpression.isValidPhone(phone: mobile){
            AlertManager.showInvalidMobile(on: self)
            return
        }
        
        if !RegularExpression.isValidPassword(password: password){
            AlertManager.showInvalidPassword(on: self)
            return
        }
        
        //let phone = "+20 115 959 2211"
        let phone = "+2\(mobile.trimmingCharacters(in: .whitespaces))"
        
        PhoneAuthManager.PhoneProvider(phoneNumber: phone) { (error, success) in
            if error != nil {
                print("errora7aaaaa")
                return
            }
            if success {
                self.toPhoneAuth(self, phone: phone, isSignUp: true)
            }
        }
    }
    
    func toPhoneAuth(_ vc: UIViewController, phone: String, isSignUp: Bool){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "PhoneAuthVC") as? PhoneAuthVC {
            desVC.phone = phone
            desVC.isSignUp = isSignUp
            desVC.delegate = self
            vc.present(desVC, animated: true)
        }
    }
    
    func signUpNow(){
        guard let firstName = firstNameField.text else {
            return
        }
        
        guard let lastName = lastNameField.text else {
            return
        }
        
        guard let email = emailField.text else {
            return
        }
        
        guard let password = passwordField.text else {
            return
        }
        
        guard let mobile = mobileField.text else {
            return
        }
        
        if !RegularExpression.isValidEmpty(text: firstName){
            AlertManager.showFillDataWithMessage(on: self, message: NSLocalizedString("firstname", comment: "firstname"))
            return
        }
        
        if !RegularExpression.isValidEmpty(text: lastName){
            AlertManager.showFillDataWithMessage(on: self, message: NSLocalizedString("lastname", comment: "lastname"))
            return
        }
        
        if !RegularExpression.isValidEmail(email: email){
            AlertManager.showInvalidEmail(on: self)
            return
        }
        
        if !RegularExpression.isValidPhone(phone: mobile){
            AlertManager.showInvalidMobile(on: self)
            return
        }
        
        if !RegularExpression.isValidPassword(password: password){
            AlertManager.showInvalidPassword(on: self)
            return
        }
        print("register here")
        LoginAPI.register(firstName: firstName, lastName: lastName, email: email, mobile: mobile, password: password, view: self.view) { (error, success) in
            if error != nil {
                AlertManager.showWrongAlert(on: self)
                return
            }
            if !success {
                AlertManager.showDuplicateEmail(on: self)
                return
            }
            NavigationManager.toHome(self)
        }
    }

}

extension SignUpVC: PhoneAuthDelegate {
    func phoneAuthenticated(success: Bool) {
        if success {
            print("succcccccccesssssssss")
            signUpNow()
        }else{
            AlertManager.showWrongAlert(on: self)
        }
    }
}
