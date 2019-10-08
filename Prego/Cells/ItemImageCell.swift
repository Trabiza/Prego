//
//  ItemImageCell.swift
//  Prego
//
//  Created by owner on 9/18/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

protocol ItemImageDelegate {
    func dismissItem() -> Void
    func favoriteAction() -> Void
}

class ItemImageCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var favImage: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDetails: UILabel!
    
    var delegate: ItemImageDelegate?
    
    func setItemInfo(item: ItemModel, mImage: String, isFavorite: Bool){
        if let title = item.nameEn {
            itemName.text = title
        }
        if let desc = item.desriptionEn {
            itemDetails.text = desc
        }
        if let info = item.info {
            if !info.isEmpty {
                if let price = info[0].priceEn {
                    itemPrice.text = "\(price) L.E."
                }
            }
        }
        ImagesManager.setImage(url: mImage, image: itemImage)
        
        if isFavorite {
            favImage.setBackgroundImage(#imageLiteral(resourceName: "lock"), for: .normal)
        }else{
            favImage.setBackgroundImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        delegate?.favoriteAction()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        delegate?.dismissItem()
    }
    
}
