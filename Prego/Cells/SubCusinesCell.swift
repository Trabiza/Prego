//
//  SubCusinesCell.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class SubCusinesCell: UITableViewCell {

    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func seImage(url: String) {
        ImagesManager.setImage(url: url, image: mImageView)
        //mImageView.image = UIImage(named: url)
    }
    
    func setPrice(info: [Info]) {
        if !info.isEmpty {
            if DefaultManager.getLanguageDefault() == Config.English {
                if let price = info[0].priceEn {
                    priceLabel.text = "\(NSLocalizedString("price_start", comment: "")) \(price)"
                }
            }else{
                if let price = info[0].priceAr {
                    priceLabel.text = "\(NSLocalizedString("price_start", comment: "")) \(price)"
                }
            }
            
        }
    }
}
