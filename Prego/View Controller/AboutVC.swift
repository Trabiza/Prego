//
//  AboutVC.swift
//  Prego
//
//  Created by owner on 10/7/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var mView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        Utilits.cornerLeftRight(view: mView)
    }
    
    @IBAction func aboutAction(_ sender: Any) {
        NavigationManager.toAboutContent(self)
    }
    
    @IBAction func termsAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutWebVC") as? AboutWebVC {
            desVC.linkURL = "http://prego-foods.com/Contact_Form/Feadback.html"
            desVC.mTitle = NSLocalizedString("terms", comment: "")
            present(desVC, animated: true)
        }
    }
    @IBAction func refundAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutWebVC") as? AboutWebVC {
            desVC.linkURL = "http://prego-foods.com/Contact_Form/Feadback.html"
            desVC.mTitle = NSLocalizedString("refund", comment: "")
            present(desVC, animated: true)
        }
    }
    
    @IBAction func privacyAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "AboutWebVC") as? AboutWebVC {
            desVC.linkURL = "http://prego-foods.com/Contact_Form/Feadback.html"
            desVC.mTitle = NSLocalizedString("privacy", comment: "")
            present(desVC, animated: true)
        }
    }

}
