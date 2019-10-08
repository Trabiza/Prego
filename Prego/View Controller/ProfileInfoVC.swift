//
//  ProfileInfoVC.swift
//  Prego
//
//  Created by owner on 9/28/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class ProfileInfoVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    
    let genderList: [String] = ["Male", "Female"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        loadData()
        
        showDatePicker()
    }
    
    func loadData(){
        guard let user = DefaultManager.getUserDefault() else{
            return
        }
        guard let data = user.data else{
            return
        }
        guard let userData = data.userData else{
            return
        }
        if let name = userData.name {
            nameField.text = name
        }
    }
    
    func setUI(){
        hideKeyboardWhenTappedAround()
        Utilits.textFieldStyle(textField: nameField)
        Utilits.textFieldStyle(textField: emailField)
        Utilits.textFieldStyle(textField: dateOfBirthField)
        Utilits.textFieldStyle(textField: genderField)
    }
    
    
    @IBAction func genderAction(_ sender: Any) {
        
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateOfBirthField.inputAccessoryView = toolbar
        dateOfBirthField.inputView = datePicker
        
        
        //Gender ToolBar
        let genderToolbar = UIToolbar();
        genderToolbar.sizeToFit()
        let genderDoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(genderDonePicker));
        
        genderToolbar.setItems([genderDoneButton], animated: false)
        
        genderPicker.delegate = self
        genderField.inputAccessoryView = genderToolbar
        genderField.inputView = genderPicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateOfBirthField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func genderDonePicker(){
        self.view.endEditing(true)
    }
}

extension ProfileInfoVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderList.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genderList[row]
    }
}


