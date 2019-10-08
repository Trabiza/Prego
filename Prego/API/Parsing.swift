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
    
    static func parseItem(jsonData: DataResponse<Any>?) -> ItemModel? {
        
        var user: ItemModel?
        do{
            user = try JSONDecoder().decode(ItemModel.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
    
    static func parseBranches(jsonData: DataResponse<Any>?) -> BranchModel? {
        
        var user: BranchModel?
        do{
            user = try JSONDecoder().decode(BranchModel.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
    static func parseAddress(jsonData: DataResponse<Any>?) -> AddressModel? {
        
        var user: AddressModel?
        do{
            user = try JSONDecoder().decode(AddressModel.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
    
    static func parseHome(jsonData: DataResponse<Any>?) -> HomeSlider? {
        
        var user: HomeSlider?
        do{
            user = try JSONDecoder().decode(HomeSlider.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
    
    static func parseCoupon(jsonData: DataResponse<Any>?) -> CouponModel? {
        
        var user: CouponModel?
        do{
            user = try JSONDecoder().decode(CouponModel.self, from: (jsonData?.data!)!)
            
        }catch {
            print("Error: \(error)")
        }
        return user!
    }
}
