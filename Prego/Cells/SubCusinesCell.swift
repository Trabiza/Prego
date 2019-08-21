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
        //ImagesManager.setImage(url: url, image: imageView)
        mImageView.image = UIImage(named: url)
    }
}
