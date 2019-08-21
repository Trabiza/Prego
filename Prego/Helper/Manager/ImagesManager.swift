//
//  ImagesManager.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit
import Kingfisher

public class ImagesManager {
    
    public static func setImage(url: String, image: UIImageView){
        
        let mUrl = "\(URLManager.imageURL)\(url)"
        guard let urlString = mUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        let placeholderImage = UIImage(named: Config.placeHolder)
        //let processor = RoundCornerImageProcessor(cornerRadius: 20)
        image.kf.indicatorType = .activity
        let resource = ImageResource(downloadURL: url, cacheKey:  urlString)
        //image.kf.setImage(with: resource, placeholder: placeholderImage , options: [])
        image.kf.setImage(with: resource, placeholder: placeholderImage, options: []) { (mImage, error, imageCacheType, imageUrl) in
            if error != nil {
                image.image = UIImage(named: Config.placeHolder)
            }
        }
    }
    
}
