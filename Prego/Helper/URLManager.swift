//
//  URLManager.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import Foundation

public class URLManager {
    static let mainURL: String              = "http://egybusiness.net/prego/api/"
    static let imageURL: String             = "http://egybusiness.net/prego/"
    
    public static let sliderURL             = mainURL + "slider"
    public static let loginURL              = mainURL + "login"
    public static let registerURL           = mainURL + "register"
    public static let facebookLoginURL      = mainURL + "login-with/facebook"
    public static let favoritesURL          = mainURL + "favorites"
    public static let menuURL               = mainURL + "menu/1"
    public static let itemURL               = mainURL + "item/"
    public static let branchesURL           = mainURL + "branches"
    public static let addFavorite           = mainURL + "like/"
    public static let removeFavorite        = mainURL + "dislike/"
    public static let checkout              = mainURL + "orders/create"
    public static let addAddress            = mainURL + "profile/address/add"
    public static let Addressess            = mainURL + "profile/address"
    public static let coupon                = mainURL + "coupon/validation"
    
}
