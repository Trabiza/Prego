//
//  CartCell.swift
//  Prego
//
//  Created by owner on 9/22/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

protocol CartDelegate {
    func deleteItem(tag: Int) -> Void
    func plusQuantity(tag: Int) -> Void
    func minusQuantity(tag: Int) -> Void
}

class CartCell: UITableViewCell {
    
    var delegate: CartDelegate?

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var allToalLabel: UILabel!
    
    func calculatePrice(quantity: Int, totalPrice: Double){
        totalPriceLabel.text = "\(totalPrice)"
        let allTotal: Double = Double(quantity) * totalPrice
        allToalLabel.text = "\(allTotal)"
    }
    
    
    @IBAction func removeAction(_ sender: Any) {
        delegate?.deleteItem(tag: tag)
    }
    @IBAction func plusAction(_ sender: Any) {
        delegate?.plusQuantity(tag: tag)
    }
    
    @IBAction func minusAction(_ sender: Any) {
        delegate?.minusQuantity(tag: tag)
    }
    
}
