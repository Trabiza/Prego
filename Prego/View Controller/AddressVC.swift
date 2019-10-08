//
//  AddressVC.swift
//  Prego
//
//  Created by owner on 9/23/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

protocol AddressesDelegate {
    func dismissAddressDelegate() -> Void
}

class AddressVC: UIViewController {
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mTableView: UITableView!
    
    let addresshNib = "AddressCell"
    var delegate: AddressesDelegate?
    var list: [Address] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNIBs()
        getAddresses()
    }
    
    func setUI(){
        Utilits.cornerLeftRight(view: mView)
        
        mTableView.separatorStyle = .none
        mTableView.rowHeight = UITableViewAutomaticDimension
        mTableView.estimatedRowHeight = 250
    }
    
    func setNIBs(){
        mTableView?.register(UINib(nibName: addresshNib, bundle: nil), forCellReuseIdentifier: addresshNib)
    }
    
    func getAddresses(){
        
        guard let token = DefaultManager.getUserToken() else {
            return
        }
        
        ProfileAPI.getAddresses(token: token, view: self.view) { (error, success, model) in
            if error != nil || !success {
                AlertManager.showWrongAlert(on: self)
                return
            }
            guard let data = model?.data else {
                AlertManager.showWrongAlert(on: self)
                return
            }
            guard let list = data.address else {
                AlertManager.showWrongAlert(on: self)
                return
            }
            self.list = list
            self.mTableView.reloadData()
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        delegate?.dismissAddressDelegate()
    }

}

extension AddressVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressCell = mTableView.dequeueReusableCell(withIdentifier: addresshNib, for: indexPath) as! AddressCell
        cell.selectionStyle = .none
        var address: String = ""
        if let street = list[indexPath.row].street {
            address += street
        }
        if let area = list[indexPath.row].area?.areaNameEn {
            address += ", \(area)"
        }
        cell.titleLabel.text = "Sheraton Al Matar"
        cell.detailsLabel.text = address
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

