//
//  LoginAPI.swift
//  Prego
//
//  Created by owner on 9/4/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginAPI : NSObject {
    
    class func loginWithEmail(email: String, password: String, view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        
        let url = URLManager.loginURL
        
        let parameters = ["email": email,
                          "password": password]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success( _):
                    if Parsing.getResponse(jsonData: response){
                        let user = Parsing.parseLogin(jsonData: response)
                        DefaultManager.saveUserDefault(user: user)
                        guard let data = user.data else {
                            return
                        }
                        guard let token = data.token else {
                            return
                        }
                        DefaultManager.saveTokenDefault(token: token)
                        completion(nil, true)
                        print("Login Success")
                    }else{
                        completion(nil, false)
                        print("Login Failed")
                    }
                }
        }
    }
    
    class func register(firstName: String, lastName: String, email: String, mobile: String, password: String, view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        
        let url = URLManager.registerURL
        
        let parameters = ["email": email,
                          "password": password,
                          "last_name": lastName,
                          "phone": mobile,
                          "first_name": firstName]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success( _):
                    if Parsing.getResponse(jsonData: response){
                        let user = Parsing.parseLogin(jsonData: response)
                        DefaultManager.saveUserDefault(user: user)
                        guard let data = user.data else {
                            return
                        }
                        guard let token = data.token else {
                            return
                        }
                        DefaultManager.saveTokenDefault(token: token)
                        completion(nil, true)
                        print("Register Success")
                    }else{
                        completion(nil, false)
                        print("Register Failed")
                    }
                }
        }
    }
    
    
    class func loginFacebook(firstName: String, lastName: String, email: String, mobile: String, facebookId: String, view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        
        let url = URLManager.facebookLoginURL
        
        let parameters = ["facebook_id": facebookId,
                          "first_name": firstName,
                          "last_name": lastName,
                          "phone": mobile,
                          "email": email]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success( _):
                    print("facebook login \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        let user = Parsing.parseLogin(jsonData: response)
                        DefaultManager.saveUserDefault(user: user)
                        guard let data = user.data else {
                            return
                        }
                        guard let token = data.token else {
                            return
                        }
                        DefaultManager.saveTokenDefault(token: token)
                        completion(nil, true)
                        print("Register Success")
                    }else{
                        completion(nil, false)
                        print("Register Failed")
                    }
                }
        }
    }
    
}


