//
//  Response.swift
//  Prego
//
//  Created by owner on 9/4/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import Foundation

struct Response : Codable{
    
    let response: Bool
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}
