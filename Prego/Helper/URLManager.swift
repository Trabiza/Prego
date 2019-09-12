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
    
    public static let loginURL              = mainURL + "login"
    public static let registerURL           = mainURL + "register"
    public static let facebookLoginURL      = mainURL + "login-with/facebook"
    public static let favoritesURL          = mainURL + "favorites"
    public static let menuURL               = mainURL + "menu"
}
