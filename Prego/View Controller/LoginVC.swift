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

class LoginVC: UIViewController ,FBSDKLoginButtonDelegate, MessagingDelegate{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let FacebookSignInBtn = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
        //Firebase Auth
        Messaging.messaging().delegate = self
        
        //Facebook Login
        FacebookLogin()
    }
    
    func setUI(){
        hideKeyboardWhenTappedAround()
        Utilits.textFieldStyle(textField: emailField, imageName: "email")
        Utilits.textFieldStyle(textField: passwordField, imageName: "lock")
    }
    
    /// Facebook Login API
    func FacebookLogin() {
        
        let layoutConstraintsArr = FacebookSignInBtn.constraints
        for lc in layoutConstraintsArr { // or attribute is NSLayoutAttributeHeight etc.
            if ( lc.constant == 28 ){
                // Then disable it...
                lc.isActive = false
                break
            }
        }
        //FacebookSignInBtn.frame = CGRect(x: 16, y: 50, width: view.frame.width - 40, height: 40)
        FacebookSignInBtn.frame = CGRect()
        view.addSubview(FacebookSignInBtn)
        
        FacebookSignInBtn.delegate = self
        FacebookSignInBtn.readPermissions = ["public_profile","email"]
    }

    @IBAction func facebookAction(_ sender: Any) {
        FacebookSignInBtn.readPermissions = ["public_profile","email"]
        
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) in
            if error != nil {
                print("Failed")
                return
            }
            
            if (FBSDKAccessToken.current()) != nil{
                self.fetchUserProfile()
            }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error ?? "Error")
            return;
        }
        print("Login success")
        if let _ = FBSDKAccessToken.current(){
            fetchUserProfile()
        }
    }
    
    @IBAction func googleAction(_ sender: Any) {
        
    }
    
    
    func fetchUserProfile(){
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, first_name, last_name, picture.type(large)"])
        
        graphRequest.start { (connection, result, error) in
            if(error != nil){
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            let fields = result as? [String:Any]
            let id = fields!["id"] as? String
            let email = fields!["email"]
            let firstName = fields!["first_name"]
            let lastName = fields!["last_name"]
            let url = "https://graph.facebook.com/\(id!)/picture?type=large&return_ssl_resources=1"
            print("login -> \(String(describing: id)) ")
            print("login -> \(String(describing: email)) ")
            print("login -> \(String(describing: firstName)) ")
            print("login -> \(String(describing: lastName)) ")
            print("login -> \(String(describing: url)) ")
            
            //self.faceBookLogin(facebook: id!, email: email as! String, firstName: firstName as! String, lastName: lastName as! String, photo: url)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Log out")
    }
}
