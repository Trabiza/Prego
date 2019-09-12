//
//  TrackOrderVC.swift
//  Prego
//
//  Created by owner on 9/12/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class TrackOrderVC: UIViewController {
    
    @IBOutlet weak var placedView: UIView!
    @IBOutlet weak var confirmedView: UIView!
    @IBOutlet weak var procesedView: UIView!
    @IBOutlet weak var readyView: UIView!
    @IBOutlet weak var enjoyView: UIView!
    
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var mView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        placedView.layer.cornerRadius = placedView.frame.width / 2
        confirmedView.layer.cornerRadius = confirmedView.frame.width / 2
        procesedView.layer.cornerRadius = procesedView.frame.width / 2
        readyView.layer.cornerRadius = readyView.frame.width / 2
        enjoyView.layer.cornerRadius = enjoyView.frame.width / 2
        
        Utilits.cornerLeftRight(view: scrollView)
    }

}
