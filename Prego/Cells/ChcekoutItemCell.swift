//
//  ChcekoutItemCell.swift
//  Prego
//
//  Created by owner on 9/25/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class ChcekoutItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    func calculatePrice(quantity: Int, totalPrice: Double){
        let allTotal: Double = Double(quantity) * totalPrice
        totalPriceLabel.text = "\(allTotal)"
    }
}
