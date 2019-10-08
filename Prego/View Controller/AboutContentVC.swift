//
//  AboutContentVC.swift
//  Prego
//
//  Created by owner on 10/7/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class AboutContentVC: UIViewController {
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var aboutTextView: UITextView!

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
}
