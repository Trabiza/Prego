//
//  CartVC.swift
//  Prego
//
//  Created by owner on 9/22/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var containerDarkView: UIView!
    @IBOutlet weak var branchConstraint: NSLayoutConstraint!
    @IBOutlet weak var addressConstraint: NSLayoutConstraint!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var pickupBtn: UIButton!
    
    let cartNib                  = "CartCell"
    var list: [Cart] = []
    var totalPriceValue: Double = 0
    
    var branchType: String = "branch"
    var addressType: String = "address"
    
    var isPickup: Bool = false
    var branch: Branch?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNIBs()
        getCart()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        hideStatusBarLine()
        Utilits.cornerLeftRight(view: subView)
        Utilits.cornerLeftRight(view: mView)
        
        mTableView.rowHeight = UITableViewAutomaticDimension
        mTableView.estimatedRowHeight = 250
        mTableView.separatorStyle = .none
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissContainerView))
        tap.cancelsTouchesInView = false
        containerDarkView.addGestureRecognizer(tap)
    }
    
    @IBAction func branchAction(_ sender: Any) {
        showContainerView(type: branchType)
    }
    
    @IBAction func addressAction(_ sender: Any) {
        showContainerView(type: addressType)
    }
    
    func showContainerView(type: String){
        containerDarkView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            switch type {
            case self.addressType:
                self.addressConstraint.constant = 280
            case self.branchType:
                self.branchConstraint.constant = 280
            default:
                self.branchConstraint.constant = 280
            }
            self.view.layoutIfNeeded()
        }) { (success) in
            print("completed")
        }
    }
    
    @objc func dismissContainerView() {
        containerDarkView.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            if self.branchConstraint.constant != 0 {
               self.branchConstraint.constant = 0
            }
            if self.addressConstraint.constant != 0 {
                self.addressConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        }) { (success) in
            print("completed")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBranch" {
            let embedVC = segue.destination as! BranchesVC
            embedVC.delegate = self
        }else if segue.identifier == "toAdress" {
            let embedVC = segue.destination as! AddressVC
            embedVC.delegate = self
        }
    }
    
    func setNIBs(){
        mTableView?.register(UINib(nibName: cartNib, bundle: nil), forCellReuseIdentifier: cartNib)
    }
    
    func getCart(){
        totalPriceValue = 0
        if let carts = CoreDaTaHandler.getCarts() {
            self.list = carts
            mTableView.reloadData()
        }
        
        list.forEach { (item) in
            totalPriceValue += Double(item.quantity) * item.total_price
        }
        totalPrice.text = "\(totalPriceValue)"
    }
    
    
    @IBAction func cashAction(_ sender: Any) {
        if isPickup {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "CheckOutVC") as? CheckOutVC {
                desVC.isPickup = isPickup
                desVC.branch = branch
                present(desVC, animated: true)
            }
        }
    }

}


extension CartVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartCell = mTableView.dequeueReusableCell(withIdentifier: cartNib, for: indexPath) as! CartCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.tag = indexPath.row
        if let title = list[indexPath.row].title {
            cell.itemName.text = title
        }
        if let desc = list[indexPath.row].desc {
            cell.detailsLabel.text = desc
        }
        if let mImage = list[indexPath.row].image {
            ImagesManager.setImage(url: mImage, image: cell.itemImage)
        }

        cell.quantityLabel.text = "\(list[indexPath.row].quantity)"
        cell.calculatePrice(quantity: Int(list[indexPath.row].quantity), totalPrice: list[indexPath.row].total_price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension CartVC: CartDelegate {
    func plusQuantity(tag: Int) {
        if let mDate = list[tag].mDate{
            let quantity = list[tag].quantity + 1
            if CoreDaTaHandler.updateCart(mDate: mDate, quantity: quantity, cart: list[tag]) {
                getCart()
            }
        }
    }
    
    func minusQuantity(tag: Int) {
        if let mDate = list[tag].mDate{
            if list[tag].quantity == 1 {
                AlertManager.showFillDataWithMessage(on: self, message: NSLocalizedString("quatity_error", comment: "quatity_error"))
            }else{
                let quantity = list[tag].quantity - 1
                
                if CoreDaTaHandler.updateCart(mDate: mDate, quantity: quantity, cart: list[tag]) {
                    getCart()
                }
            }
        }
    }
    
    func deleteItem(tag: Int) {
        if let mDate = list[tag].mDate {
            if CoreDaTaHandler.deleteObject(id: mDate) {
                getCart()
            }else{
                AlertManager.showWrongAlert(on: self)
            }
        }
    }
    
    
}


extension CartVC: BranchesDelegate {
    
    func passBranch(branch: Branch) {
        dismissContainerView()
        isPickup = true
        if let title = branch.addressEn {
            pickupBtn.setTitle(title, for: .normal)
        }
        self.branch = branch
        //NavigationManager.toCheckout(self)
    }
    func dismissBranchDelegate() {
        dismissContainerView()
    }
}

extension CartVC: AddressesDelegate {
    func dismissAddressDelegate() {
        dismissContainerView()
    }
    
}

