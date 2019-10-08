//
//  Coupon.swift
//  Prego
//
//  Created by owner on 10/7/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import Foundation

struct CouponModel: Codable {
    let response: Bool?
    let coupon: Coupon?
}

// MARK: - Coupon
struct Coupon: Codable {
    let code: String?
    let fixed: Int?
    let percentage: Int?
    let couponDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case code, fixed, percentage
        case couponDescription = "description"
    }
}
