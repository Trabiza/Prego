//
//  FacebookGoogleVC.swift
//  Prego
//
//  Created by owner on 9/4/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseMessaging
import GoogleSignIn


class FacebookGoogleVC: UIViewController ,FBSDKLoginButtonDelegate, MessagingDelegate{

    let FacebookSignInBtn = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Firebase Auth
        Messaging.messaging().delegate = self
        
        //Facebook Login
        FacebookLogin()
    }
    
    /// Facebook Login API
    func FacebookLogin() {
        
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
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
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
            
            self.facebookLoginAPI(facebook: id!, email: email as! String, firstName: firstName as! String, lastName: lastName as! String)
        }
    }
    
    func facebookLoginAPI(facebook: String, email: String, firstName: String, lastName: String){
        LoginAPI.loginFacebook(firstName: firstName, lastName: lastName, email: email, mobile: "", facebookId: facebook, view: self.view) { (error, success) in
            if error != nil || !success {
                AlertManager.showWrongAlert(on: self)
                return
            }
            NavigationManager.toHome(self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Log out")
    }

}


extension FacebookGoogleVC: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error ?? "Error")
            return;
        }
        
        guard let id = user.userID else {
            return
        }
        
        guard let email = user.profile.email  else {
            return
        }
        
        guard let firstName = user.profile.givenName  else {
            return
        }
        
        guard let lastName = user.profile.familyName  else {
            return
        }
        
        var image: String = ""
        if let mImage = user.profile.imageURL(withDimension: 150) {
            image = mImage.absoluteString
        }
        
        print("Google data \(id) \(email) \(firstName) url:  \(lastName)")
        
        //self.googleLogin(google: id, email: email, firstName: firstName, lastName: lastName, photo: image)
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
