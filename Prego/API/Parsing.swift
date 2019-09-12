//
//  Parsing.swift
//  Prego
//
//  Created by owner on 9/4/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import Alamofire

public class Parsing {
    
    
    //Get response from server {TRUE or FALSE}
    static func getResponse(jsonData: DataResponse<Any>?) -> Bool {
        
        var response: Bool = false
        
        do{
            let resultObject = try JSONDecoder().decode(Response.self, from: (jsonData?.data!)!)
            if resultObject.response {
                response = true
            }else{
                response = false
            }
        }catch {
            print("Error: \(error)")
        }
        
        return response
    }
    
    //Parse Login
    static func parseLogin(jsonData: DataResponse<Any>?) -> User {
        
        var user: User?
        do{
            user = try JSONDecoder().decode(User.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
    
    static func parseFavorites(jsonData: DataResponse<Any>?) -> FavoriteModel? {
        
        var user: FavoriteModel?
        do{
            user = try JSONDecoder().decode(FavoriteModel.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
    
    static func parseMenus(jsonData: DataResponse<Any>?) -> MenuModel? {
        
        var user: MenuModel?
        do{
            user = try JSONDecoder().decode(MenuModel.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }

}
