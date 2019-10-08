//
//  MenuAPI.swift
//  Prego
//
//  Created by owner on 9/12/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuAPI : NSObject {
    
    class func menus(view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool,_ menu: [Menu]?)->Void) {
        
        let url = URLManager.menuURL
        
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
                        if let model = Parsing.parseMenus(jsonData: response) {
                            guard let data = model.data else{
                                completion(nil, false, nil)
                                return
                            }
                            guard let list = data.menu else {
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
    
    
    class func item(itemID: String, view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool,_ menu: ItemModel?)->Void) {
        
        let url = "\(URLManager.itemURL)\(itemID)"
        var api_token: String = ""
        if let token = DefaultManager.getUserToken() {
            api_token = token
        }
        let parameters = ["api_token": api_token]
        
        Alamofire.request(url, method: .get, parameters: parameters,encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                case .success( _):
                    print("item loading is \(String(describing: response.result.value))")
                    if let model = Parsing.parseItem(jsonData: response) {
                        print("successss")
                        completion(nil, true, model)
                    }else{
                        print("Failedddd")
                        completion(nil, false, nil)
                    }
                }
        }
    }
    
    class func branches(view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool,_ menu: BranchModel?)->Void) {
        
        let url = URLManager.branchesURL
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                case .success( _):
                    print("item loading is \(String(describing: response.result.value))")
                    if let model = Parsing.parseBranches(jsonData: response) {
                        print("successss")
                        completion(nil, true, model)
                    }else{
                        print("Failedddd")
                        completion(nil, false, nil)
                    }
                }
        }
    }
    
    class func favorite(isFav: Bool, itemID: String, api_token: String ,view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        
        var url: String = ""
        if isFav {
            print("unfavorite ya man")
            url = "\(URLManager.removeFavorite)\(itemID)"
        }else{
            print("favorite ya man")
            url = "\(URLManager.addFavorite)\(itemID)"
        }
        
        print("fav url is \(url)")
        let parameters = ["api_token": api_token]
        
        Alamofire.request(url, method: .get, parameters: parameters,encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success( _):
                    print("item loading is \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        print("successss")
                        completion(nil, true)
                    }else{
                        print("Failedddd")
                        completion(nil, false)
                    }
                }
        }
    }
    
    
    
    class func checkout(apiToken: String, items: NSMutableDictionary, payment: String, lat: String, lng: String, address: String, mBranch: String ,view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        
        let url: String = URLManager.checkout
        
        let jsonData = try! JSONSerialization.data(withJSONObject: items, options: [])
        let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
        
        print("responseJson \(jsonString)")
        
        let parameters = ["api_token": apiToken,
                          "items": jsonString,
                          "payment": "3",
                          "lat": "30.1026346",
                          "lng": "31.3761231",
                          "address": "1",
                          "branch": mBranch] as [String : Any]// as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                case .success( _):
                    print("checkout results is \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        print("successss")
                        completion(nil, true)
                    }else{
                        print("Failedddd")
                        completion(nil, false)
                    }
                }
        }
    }
    
    
    class func coupon(apiToken: String, mCoupon: String, mDay: String, mTime: String ,view: UIView ,completion: @escaping (_ error: Error?, _ success: Bool, _ model: CouponModel?)->Void) {
        
        let url: String = URLManager.coupon
        
        let parameters = ["api_token": apiToken,
                          "coupon": mCoupon,
                          "day": mDay,
                          "time": mTime]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<800)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                case .success( _):
                    print("checkout results is \(String(describing: response.result.value))")
                    if Parsing.getResponse(jsonData: response){
                        print("successss")
                        if let model = Parsing.parseCoupon(jsonData: response) {
                            print("successss")
                            completion(nil, true, model)
                        }else{
                            print("Failedddd")
                            completion(nil, false, nil)
                        }
                    }else{
                        print("Failedddd")
                        completion(nil, false, nil)
                    }
                }
        }
    }
}
