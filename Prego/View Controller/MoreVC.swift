//
//  MoreVC.swift
//  Prego
//
//  Created by owner on 9/17/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class MoreVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI(){
        Utilits.cornerLeftRight(view: scrollView)
    }
    
    @IBAction func aboutAction(_ sender: Any) {
        NavigationManager.toAbout(self)
    }
    
    @IBAction func newsAction(_ sender: Any) {
        NavigationManager.toNews(self)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        NavigationManager.toProfile(self)
    }
    
    @IBAction func contactAction(_ sender: Any) {
        NavigationManager.toContact(self)
    }
    
    @IBAction func historyAction(_ sender: Any) {
        NavigationManager.toHistory(self)
    }
    
    @IBAction func cartAction(_ sender: Any) {
        NavigationManager.toCart(self)
    }

    @IBAction func arabicAction(_ sender: Any) {
        Utilits.arabicActin(self)
    }
    
    @IBAction func englishAction(_ sender: Any) {
        Utilits.englishAction(self)
    }
}
