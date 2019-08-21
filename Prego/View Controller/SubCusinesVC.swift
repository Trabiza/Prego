//
//  SubCusinesVC.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class SubCusinesVC: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mView: UIView!
    
    let nibCellName: String = "SubCusinesCell"
    var mList: [String] = ["first.jpg", "second.jpg", "third.jpeg",
                           "first.jpg", "second.jpg", "third.jpeg",
                           "first.jpg", "second.jpg", "third.jpeg",
                           "first.jpg", "second.jpg", "third.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerTableView()
    }

    func setUI(){
        hideStatusBarLine()
        Utilits.cornerLeftRight(view: mView)
    }
    
    func registerTableView(){
        mTableView.separatorStyle = .none
        mTableView.rowHeight = UITableViewAutomaticDimension
        mTableView.estimatedRowHeight = 270
        mTableView.register(UINib(nibName: nibCellName, bundle: nil), forCellReuseIdentifier: nibCellName)
    }
}

extension SubCusinesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubCusinesCell = mTableView.dequeueReusableCell(withIdentifier: nibCellName, for: indexPath) as! SubCusinesCell
        cell.seImage(url: mList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
