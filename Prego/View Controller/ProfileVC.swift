//
//  ProfileVC.swift
//  Prego
//
//  Created by owner on 9/28/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var addressImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var infoContainerView: UIView!

    let infoType: String = "info"
    let addressType: String = "address"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func infoAction(_ sender: Any) {
        toogleAction(type: infoType)
    }
    
    @IBAction func addressAction(_ sender: Any) {
        toogleAction(type: addressType)
    }
    
    func toogleAction(type: String){
        switch type {
        case infoType:
            infoChoosed()
            break
        case addressType:
            addressChoosed()
            break
        default:
            break
        }
    }
    
    func infoChoosed(){
        
        self.infoLabel.textColor = AppColorsManager.orangeColor
        self.infoView.backgroundColor = AppColorsManager.orangeColor
        
        self.infoImage.image = self.infoImage.image?.withRenderingMode(.alwaysTemplate)
        self.infoImage.tintColor = AppColorsManager.orangeColor
        
        self.addressLabel.textColor = UIColor.darkGray
        self.addressView.backgroundColor = UIColor.lightGray
        
        self.addressImage.image = self.addressImage.image?.withRenderingMode(.alwaysTemplate)
        self.addressImage.tintColor = UIColor.darkGray
        
        self.infoContainerView.isHidden = false
        self.addressContainerView.isHidden = true
    }
    
    func addressChoosed(){
        addressLabel.textColor = AppColorsManager.orangeColor
        addressView.backgroundColor = AppColorsManager.orangeColor
        
        addressImage.image = addressImage.image?.withRenderingMode(.alwaysTemplate)
        addressImage.tintColor = AppColorsManager.orangeColor
        
        infoLabel.textColor = UIColor.darkGray
        infoView.backgroundColor = UIColor.lightGray
        
        infoImage.image = infoImage.image?.withRenderingMode(.alwaysTemplate)
        infoImage.tintColor = UIColor.darkGray
        
        self.infoContainerView.isHidden = true
        self.addressContainerView.isHidden = false
    }

}
