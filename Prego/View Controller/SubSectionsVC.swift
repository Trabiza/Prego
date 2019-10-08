//
//  SubSectionsVC.swift
//  Prego
//
//  Created by owner on 9/12/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class SubSectionsVC: UIViewController {
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var bagView: UIView!
    
    let subCusinesSegue: String = "subCusinesSegue"
    let nibCellName: String = "CusinesCell"
    var mList: [Menu] = []
    var barTitle: String = "Menu"

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        registerCollection()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        setupBagView(bagView: bagView)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        hideStatusBarLine()
        Utilits.cornerLeftRight(view: mView)
        titleLabel.text = barTitle
        
        
    }
    
    func registerCollection(){
        mCollectionView.register(UINib(nibName: nibCellName, bundle: nil), forCellWithReuseIdentifier: nibCellName)
    }
    
    func loadMenus(){
        MenuAPI.menus(view: self.view) { (error, success, list) in
            if error != nil || !success {
                return
            }
            if list != nil {
                if (list?.count)! > 0 {
                    self.mList = list![0].sections!
                    self.mCollectionView.reloadData()
                }
            }
            
        }
    }
}

extension SubSectionsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CusinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: nibCellName , for: indexPath) as! CusinesCell
        cell.shadowAndBorderForCell(cell: cell)
        
        if let image = mList[indexPath.row].image {
            cell.seImage(url: image)
        }
        if DefaultManager.getLanguageDefault() == Config.English {
            if let title = mList[indexPath.row].nameEn {
                cell.titleLabel.text = title
            }
        }else{
            if let title = mList[indexPath.row].nameAr {
                cell.titleLabel.text = title
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( self.view.frame.width / 2 ) - 16
        let height = width - 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 10, bottom: 8, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: subCusinesSegue, sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == subCusinesSegue {
            let desVC = segue.destination as! SubCusinesVC
            guard let sectionItems = mList[sender as! Int].items else {
                return
            }
            desVC.list = sectionItems
            if DefaultManager.getLanguageDefault() == Config.English {
                if let title = mList[sender as! Int].nameEn {
                    desVC.barTitle = title
                }
            }else{
                if let title = mList[sender as! Int].nameAr {
                    desVC.barTitle = title
                }
            }
        }
    }
}
