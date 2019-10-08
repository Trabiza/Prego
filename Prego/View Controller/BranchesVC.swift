//
//  BranchesVC.swift
//  Prego
//
//  Created by owner on 9/23/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

protocol BranchesDelegate {
    func dismissBranchDelegate() -> Void
    func passBranch(branch: Branch) -> Void
}

class BranchesVC: UIViewController {
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mTableView: UITableView!
    
    let branchNib = "BranchCell"
    var delegate: BranchesDelegate?
    var list: [Branch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNIBs()
        getBranches()
    }

    func setUI(){
        Utilits.cornerLeftRight(view: mView)
        
        mTableView.separatorStyle = .none
        mTableView.rowHeight = UITableViewAutomaticDimension
        mTableView.estimatedRowHeight = 250
    }
    
    func setNIBs(){
        mTableView?.register(UINib(nibName: branchNib, bundle: nil), forCellReuseIdentifier: branchNib)
    }
    
    func getBranches(){
        MenuAPI.branches(view: self.view) { (error, success, model) in
            if error != nil || !success {
                return
            }
            guard let data = model?.data else {
                return
            }
            guard let list = data.branches else {
                return
            }
            self.list = list
            self.mTableView.reloadData()
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        delegate?.dismissBranchDelegate()
    }
}

extension BranchesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BranchCell = mTableView.dequeueReusableCell(withIdentifier: branchNib, for: indexPath) as! BranchCell
        cell.selectionStyle = .none
        if let title = list[indexPath.row].nameEn {
            cell.titleLabel.text = title
        }
        if let address = list[indexPath.row].addressEn {
            cell.detailsLabel.text = address
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.passBranch(branch: list[indexPath.row])
    }
}
