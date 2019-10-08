//
//  AddCartCell.swift
//  Prego
//
//  Created by owner on 9/22/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

protocol AddCartDelegate {
    func cartClicked() -> Void
}

class AddCartCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addCartBtn: UIButton!
    @IBOutlet weak var mView: UIView!
    
    var delegate: AddCartDelegate?
    
    @IBAction func addCartAction(_ sender: Any) {
        delegate?.cartClicked()
    }
}
