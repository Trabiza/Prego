//
//  HistoryVC.swift
//  Prego
//
//  Created by owner on 10/7/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mView: UIView!
    
    let historyNib = "HistoryCell"

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
        mTableView?.register(UINib(nibName: historyNib, bundle: nil), forCellReuseIdentifier: historyNib)
    }

}

extension HistoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryCell = mTableView.dequeueReusableCell(withIdentifier: historyNib, for: indexPath) as! HistoryCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

