//
//  ProfileAPI.swift
//  Prego
//
//  Created by owner on 9/12/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileAPI : NSObject {
    
    class func slider(view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool,_ favorites: [Slider]?)->Void) {
        
        let url = URLManager.sliderURL
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                case .success( _):
                    print("favorites list \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        if let model = Parsing.parseHome(jsonData: response) {
                            guard let data = model.data else {
                                completion(nil, false, nil)
                                return
                            }
                            guard let list = data.slider else {
                                completion(nil, false, nil)
                                return
                            }
                            completion(nil, true, list)
                        }else{
                            print("Failed")
                            completion(nil, false, nil)
                        }
                    }else{
                        completion(nil, false, nil)
                        print("Register Failed")
                    }
                }
        }
    }
    
    class func favorites(token: String, view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool,_ favorites: [Favorite]?)->Void) {
        
        let url = URLManager.favoritesURL
        
        let parameters = ["api_token": token]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                case .success( _):
                    print("favorites list \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        if let model = Parsing.parseFavorites(jsonData: response) {
                            guard let data = model.data else{
                                completion(nil, false, nil)
                                return
                            }
                            guard let list = data.favorites else {
                                completion(nil, false, nil)
                                return
                            }
                            completion(nil, true, list)
                        }else{
                            print("Failed")
                            completion(nil, false, nil)
                        }
                    }else{
                        completion(nil, false, nil)
                        print("Register Failed")
                    }
                }
        }
    }
    
    
    class func addAddress(token: String, name: String,city: String, area: String, street: String, building: String, mFloor: String, apartment: String, lat: String, lang: String, aadditional: String ,view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        
        let url = URLManager.addAddress
        
        let parameters = ["api_token": token,
                          "name": name,
                          "city": city,
                          "area": area,
                          "street": street,
                          "building": building,
                          "floor": mFloor,
                          "apt": apartment,
                          "lat": lat,
                          "lng": lang,
                          "additional": aadditional]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success( _):
                    print("favorites list \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        
                        completion(nil, true)
                    }else{
                        completion(nil, false)
                        print("Register Failed")
                    }
                }
        }
    }
    
    class func getAddresses(token: String, view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool, _ model: AddressModel?)->Void) {
        
        let url = URLManager.Addressess
        
        let parameters = ["api_token": token]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                case .success( _):
                    print("favorites list \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        if let model = Parsing.parseAddress(jsonData: response) {
                            completion(nil, true, model)
                        }else{
                            completion(nil, false, nil)
                        }
                    }else{
                        completion(nil, false, nil)
                        print("Register Failed")
                    }
                }
        }
    }
}
