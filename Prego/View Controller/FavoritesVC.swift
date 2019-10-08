//
//  FavoritesVC.swift
//  Prego
//
//  Created by owner on 9/12/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var bagView: UIView!
    
    let nibCellName: String = "SubCusinesCell"
    var list: [Favorite] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        setupBagView(bagView: bagView)
        loadData()
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
    
    func loadData(){
        
        guard let token = DefaultManager.getUserToken() else {
            return
        }
        
        ProfileAPI.favorites(token: token, view: self.view) { (error, success, list) in
            if error != nil || !success {
                return
            }
            self.list = list!
            self.mTableView.reloadData()
            print("fav count \(self.list.count)")
        }
    }

}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubCusinesCell = mTableView.dequeueReusableCell(withIdentifier: nibCellName, for: indexPath) as! SubCusinesCell
        cell.selectionStyle = .none
        if let item = list[indexPath.row].itemName {
            if DefaultManager.getLanguageDefault() == Config.English {
                if let name = item.nameEn {
                    cell.titleLabel.text = name
                }
                if let desc = item.desriptionEn {
                    cell.detailsLabel.text = desc
                }
            }else{
                if let name = item.nameAr {
                    cell.titleLabel.text = name
                }
                if let desc = item.desriptionAr {
                    cell.detailsLabel.text = desc
                }
                
            }
            if let info = item.info {
                cell.setPrice(info: info)
            }
            if let image = item.image {
                cell.seImage(url: image)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let itemID = list[indexPath.row].itemID else {
            return
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            desVC.itemID = "\(itemID)"
            self.present(desVC, animated: true)
        
        }
    }
}
