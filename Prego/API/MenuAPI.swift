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
    
}
