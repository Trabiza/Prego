//
//  BagVC.swift
//  Prego
//
//  Created by owner on 9/28/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class BagVC: UIViewController {

    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var subSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let carts = CoreDaTaHandler.getCarts() {
            if carts.count != 0 {
                squareView.isHidden = false
                countLabel.text = "\(carts.count)"
            }else{
                squareView.isHidden = true
            }
        }
    }
    
    @IBAction func bagAction(_ sender: Any) {
        NavigationManager.toCart(self)
    }

}
