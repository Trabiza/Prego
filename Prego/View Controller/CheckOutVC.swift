//
//  CheckOutVC.swift
//  Prego
//
//  Created by owner on 9/25/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

enum PaymentMehod: String {
    case Cash = "1"
    case VISA = "2"
    case PickUP = "3"
}

struct CheckoutModel {
    var type: String = ""
    var row: Int = 1
}

class CheckOutVC: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var subSuccessView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var AmountPriceLabel: UILabel!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var couponField: UITextField!
    @IBOutlet weak var couponBtn: UIButton!
    
    let checkoutItemNib = "ChcekoutItemCell"
    let checkoutAddressNIB = "CheckoutAddressCell"
    
    var list: [Cart] = []
    var totalPriceValue: Double = 0
    
    var sections: [CheckoutModel] = []
    var itemType: String = "item"
    var addressType: String = "addrress"
    var specialRequest: String = ""
    var isPickup: Bool = false
    var PAYMENT_TYPE: String = ""
    
    var branch: Branch?
    var branchList: [Branch] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBranchOrAddress()
        setUI()
        setNIBs()
        getCart()
    }
    
    //Get json of cart items
    func createJsonObjectFromCart() -> NSMutableDictionary{
        var infoId: String = ""
        var extraIDs: String = ""
        var optionsIDs: String = ""
        var quantity: String = ""
        
        let para:NSMutableDictionary = NSMutableDictionary()
        let prodArray:NSMutableArray = NSMutableArray()
        
        //para.setValue("1", forKey: "payment")
        //para.setValue("2", forKey: "branch")
        
        list.forEach { (cart) in
            let prod: NSMutableDictionary = NSMutableDictionary()
            if let id = cart.info_id {
                infoId = id
            }
            if let extras = cart.extra_ids {
                extraIDs = extras
            }
            if let options = cart.options_ids {
                optionsIDs = options
            }
            quantity = "\(cart.quantity)"
            
            
            prod.setValue(infoId, forKey: "id")
            prod.setValue(convertStringToArray(value: extraIDs), forKey: "extras")
            prod.setValue(convertStringToArray(value: optionsIDs), forKey: "options")
            prod.setValue(quantity, forKey: "count")
            prod.setValue(cart.special_request ?? "", forKey: "special")
            
            prodArray.add(prod)
        }
        para.setObject(prodArray, forKey: "items" as NSCopying)
        return para
    }
    
    func convertStringToArray(value: String) -> [String]{
        if value.isEmpty {
            return []
        }
        return value.components(separatedBy: ",")
    }
    
    //Check if pickup or delivery
    func setupBranchOrAddress(){
        if isPickup {
            PAYMENT_TYPE = PaymentMehod.PickUP.rawValue
            if branch != nil {
                branchList.append(branch!)
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        hideStatusBarLine()
        Utilits.cornerLeftRight(view: subView)
        Utilits.cornerLeftRight(view: mView)
        Utilits.cornerLeftRight(view: subSuccessView)
        
        hideKeyboardWhenTappedAround()
        
        mTableView.separatorStyle = .none
        mTableView.rowHeight = UITableViewAutomaticDimension
        mTableView.estimatedRowHeight = 250
    }
    
    func setNIBs(){
        mTableView?.register(UINib(nibName: checkoutItemNib, bundle: nil), forCellReuseIdentifier: checkoutItemNib)
        mTableView?.register(UINib(nibName: checkoutAddressNIB, bundle: nil), forCellReuseIdentifier: checkoutAddressNIB)
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
        if isPickup {
            sections.append(CheckoutModel(type: addressType, row: branchList.count))
        }
        sections.append(CheckoutModel(type: itemType, row: list.count))
        totalPriceLabel.text = "\(totalPriceValue)"
        AmountPriceLabel.text = "\(totalPriceValue + 10)"
    }
    
    @IBAction func placeOrderAction(_ sender: Any) {
        if isPickup {
            placeOrderAsPickup()
        }
    }
    
    func placeOrderAsPickup(){
        guard let token = DefaultManager.getUserToken() else {
            //need login
            return
        }
        guard let branchID = branch?.id else {
            AlertManager.showWrongAlert(on: self)
            return
        }
        if list.isEmpty {
            return
        }
        if PAYMENT_TYPE.isEmpty {
            AlertManager.showWrongAlert(on: self)
            return
        }
        
        MenuAPI.checkout(apiToken: token, items: createJsonObjectFromCart(), payment: PAYMENT_TYPE, lat: "", lng: "", address: "", mBranch: "\(branchID)", view: self.view) { (error, success) in
            if error != nil || !success {
                AlertManager.showWrongAlert(on: self)
                return
            }
            self.successOrder()
        }
    }
    
    func successOrder(){
        print("heeeey success")
        if CoreDaTaHandler.cleanData() {
            self.successView.isHidden = false
        }
    }
    
    //Coupon Validation
    @IBAction func couponAction(_ sender: Any) {
        guard let coupoun = couponField.text else {
            return
        }
        if coupoun.isEmpty {
            return
        }
        getCoupon(mCoupon: coupoun)
    }
    
    func getCoupon(mCoupon: String){
        guard let token = DefaultManager.getUserToken() else {
            return
        }

        MenuAPI.coupon(apiToken: token, mCoupon: mCoupon, mDay: Utilits.getCurrentDate(), mTime: Utilits.getCurrentTime(), view: self.view) { (error, success, model) in
            
            if error != nil || !success {
                self.invalidCoupon()
                return
            }
            guard let coupon = model?.coupon else {
                self.invalidCoupon()
                return
            }
            self.validCoupon(coupon: coupon)
            
        }
    }
    
    func invalidCoupon(){
        self.couponLabel.text = NSLocalizedString("invalid_coupon", comment: "")
        self.couponLabel.textColor = UIColor.red
    }
    
    func validCoupon(coupon: Coupon){
        if let fixedPrice = coupon.fixed {
            self.couponLabel.text = "Discout \(fixedPrice) form total price"
            self.couponLabel.textColor = UIColor.green
        }else{
            if let percentage = coupon.percentage {
                self.couponLabel.text = "Discout \(getPriceDiscountPrice(percentage: percentage)) form total price"
                self.couponLabel.textColor = UIColor.green
                self.couponLabel.textColor = UIColor.green
            }
        }
    }
    
    func getPriceDiscountPrice(percentage: Int) -> Double{
        let discountPrice: Double = (totalPriceValue * Double(percentage)) / 100
        return discountPrice
    }
    
    //Success View display after success order
    @IBAction func trackOrderAction(_ sender: Any) {
        if isPickup {
            placeOrderAsPickup()
        }
    }
    
    @IBAction func orderAginAction(_ sender: Any) {
        if isPickup {
            placeOrderAsPickup()
        }
    }
    
}


extension CheckOutVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section]
        
        switch item.type {
            
        case addressType:
            let cell: CheckoutAddressCell = mTableView.dequeueReusableCell(withIdentifier: checkoutAddressNIB, for: indexPath) as! CheckoutAddressCell
            cell.selectionStyle = .none
            if isPickup {
                if let title = branchList[indexPath.row].nameEn {
                    cell.typeLabel.text = title
                }
                
                if let address = branchList[indexPath.row].addressEn {
                    cell.addressLabel.text = address
                }
            }
            return cell
            
        case itemType:
            let cell: ChcekoutItemCell = mTableView.dequeueReusableCell(withIdentifier: checkoutItemNib, for: indexPath) as! ChcekoutItemCell
            cell.selectionStyle = .none
            
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
            
            cell.calculatePrice(quantity: Int(list[indexPath.row].quantity), totalPrice: list[indexPath.row].total_price)
            
            return cell
        
        default:
            let cell: ChcekoutItemCell = mTableView.dequeueReusableCell(withIdentifier: checkoutItemNib, for: indexPath) as! ChcekoutItemCell
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

