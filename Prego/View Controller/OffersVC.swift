//
//  OffersVC.swift
//  Prego
//
//  Created by owner on 10/8/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class OffersVC: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mView: UIView!
    
    let offerNib = "OfferCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
        setNIBs()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        Utilits.cornerLeftRight(view: mView)
        
        mTableView.separatorStyle = .none
        mTableView.rowHeight = UITableViewAutomaticDimension
        mTableView.estimatedRowHeight = 250
    }
    
    func setNIBs(){
        mTableView?.register(UINib(nibName: offerNib, bundle: nil), forCellReuseIdentifier: offerNib)
    }
}

extension OffersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OfferCell = mTableView.dequeueReusableCell(withIdentifier: offerNib, for: indexPath) as! OfferCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


