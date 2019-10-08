//
//  AddAddressVC.swift
//  Prego
//
//  Created by owner on 9/24/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class AddAddressVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var areaField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var buildingField: UITextField!
    @IBOutlet weak var floorField: UITextField!
    @IBOutlet weak var apartmentField: UITextField!
    @IBOutlet weak var additionalField: UITextField!
    
    var userAddress: UserAddress? = nil
    
    var country: String = ""
    var city: String = ""
    var area: String = ""
    var street: String = ""
    var building: String = ""
    var mFloor: String = ""
    var apartment: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var additional: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        fillData()
        setUI()
    }
    
    func fillData(){
        if let city = userAddress?.city {
            cityField.text = city
            self.city = city
            cityField.isUserInteractionEnabled = false
        }
        if let area = userAddress?.region {
            self.area = area
            areaField.text = area
            areaField.isUserInteractionEnabled = false
        }
        if let street = userAddress?.street {
            self.street = street
            streetField.text = street
        }
        if let lat = userAddress?.latitude {
            latitude = lat
        }
        if let lang = userAddress?.longitude {
            longitude = lang
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        hideStatusBarLine()
        Utilits.cornerLeftRight(view: scrollView)
        
        Utilits.textFieldStyle(textField: cityField)
        Utilits.textFieldStyle(textField: areaField)
        Utilits.textFieldStyle(textField: streetField)
        Utilits.textFieldStyle(textField: buildingField)
        Utilits.textFieldStyle(textField: floorField)
        Utilits.textFieldStyle(textField: apartmentField)
        Utilits.textFieldStyle(textField: additionalField)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        addAddress()
    }
    
    func addAddress(){
        guard let token = DefaultManager.getUserToken() else {
            return
        }
        guard let city = cityField.text else {
            return
        }
        guard let area = areaField.text else {
            return
        }
        guard let street = streetField.text else {
            return
        }
        guard let building = buildingField.text else {
            return
        }
        guard let mFloor = floorField.text else {
            return
        }
        guard let apartment = apartmentField.text else {
            return
        }
        if city.isEmpty || area.isEmpty || street.isEmpty || street.isEmpty || building.isEmpty || mFloor.isEmpty || apartment.isEmpty{
            AlertManager.showWrongAlertWithMessage(on: self, message: NSLocalizedString("fields_required", comment: ""))
            return
        }
        
        if let additional = additionalField.text {
            self.additional = additional
        }
        
        ProfileAPI.addAddress(token: token, name: "Home", city: city, area: area, street: street, building: building, mFloor: mFloor, apartment: apartment, lat: "\(latitude)", lang: "\(longitude)", aadditional: additional, view: self.view) { (error, success) in
            if error != nil || !success {
                AlertManager.showWrongAlert(on: self)
                return
            }
            print("Added successfully")
        }
    }
    
}
