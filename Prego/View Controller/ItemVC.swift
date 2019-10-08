//
//  ItemVC.swift
//  Prego
//
//  Created by owner on 9/16/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

enum Sections {
    case Image
    case Size
    case Extras
}

class ItemVC: UIViewController {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var itemImageNib               = "ItemsImageCell"
    let itemSizeNib                 = "ItemSizeCell"
    let itemExtraNib                = "ItemExtraCell"
    let homeReusableViewID        = "HomeReusableView"
    
    var sectionDic: [Int] = []
    
    var sectionTitles: [String] = ["Images", "Sizes"]
    
    var sizeList: [ItemInfo] = []
    var extraList: [ItemExtra] = []
    
    var extraListItems: [Int: [ItemExtra]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getItem()
        setNIBs()
    }
    
    func getItem(){
        MenuAPI.item(itemID: "1", view: self.view) { (error, success, model) in
            if error != nil || !success {
                return
            }
            if let infoList = model?.info {
                self.sizeList = infoList
                self.sectionDic.append(0)
                self.sectionDic.append(1)
                self.mCollectionView.reloadData()
                //self.mCollectionView.reloadSections(IndexSet(integer: self.sectionDic[.Size]!))
            }
        }
    }
    
    func setUI(){
        mCollectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height
    }
    
    func setNIBs(){
        mCollectionView.register(UINib(nibName: itemImageNib, bundle: nil), forCellWithReuseIdentifier: itemImageNib)
        mCollectionView.register(UINib(nibName: itemSizeNib, bundle: nil), forCellWithReuseIdentifier: itemSizeNib)
        mCollectionView.register(UINib(nibName: itemExtraNib, bundle: nil), forCellWithReuseIdentifier: itemExtraNib)
        mCollectionView.register(UINib(nibName: homeReusableViewID, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: homeReusableViewID)
    }
}

/*extension ItemVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionDic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return sizeList.count
        }else if section > 1 {
            let items = extraListItems[section]
            if items != nil {
                print("extraListItems count \(String(describing: items?.count))")
                return (items?.count)!
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell:ItemsImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemImageNib, for: indexPath) as! ItemsImageCell
            
            return cell
        }else if indexPath.section == 1 {
            let cell:ItemSizeCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemSizeNib, for: indexPath) as! ItemSizeCell
            if let name = sizeList[indexPath.row].size {
                cell.sizeLabel.text = name
            }
            return cell
        }else  {
            self.extraList = extraListItems[indexPath.section]!
            let cell:ItemExtraCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemExtraNib, for: indexPath) as! ItemExtraCell
            
            if let data = extraList[indexPath.row].nameEn {
                cell.extraLabel.text = data
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 390)
        }else if indexPath.section == 1 {
            return CGSize(width: view.frame.width, height: 45)
        }else {
            return CGSize(width: view.frame.width, height: 45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else if section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var resuable: UICollectionReusableView? = nil
        if kind == UICollectionElementKindSectionHeader {
            
            let cell: HomeReusableView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: homeReusableViewID, for: indexPath) as? HomeReusableView)!
            
            cell.headerLabel.text = sectionTitles[indexPath.section]
            resuable = cell
            return resuable!
        }
        return resuable!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: 0, height: 50)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
        }else if indexPath.section == 1 {
            let cell = collectionView.cellForItem(at: indexPath) as? ItemSizeCell
            cell?.mImage.image = UIImage(named: "radio-full")
            self.loadExtras(indexPath: indexPath)
            /*self.extraList.removeAll()
            self.sectionDic.removeAll()
            sectionDic.append(0)
            sectionDic.append(1)
            if let extras = sizeList[indexPath.row].itemExtras {
                for (index, extra) in extras.enumerated() {
                    sectionDic.append(index + 2)
                    if let title = extra.categoryEn {
                        sectionTitles.append(title)
                    }
                    if let data = extra.data {
                        data.forEach({ (item) in
                            self.extraList.append(item)
                            self.mCollectionView.reloadData()
                        })
                    }
                    self.mCollectionView.reloadSections(IndexSet(integer: index + 2))
                }
                //self.extraList = extras
                //self.mCollectionView.reloadSections(IndexSet(integer: self.sectionDic[.Extras]!))
            }*/
        }
    }
    
    func loadExtras(indexPath: IndexPath){
        self.extraListItems.removeAll()
        self.sectionDic.removeAll()
        sectionDic.append(0)
        sectionDic.append(1)
        if let extras = sizeList[indexPath.row].itemExtras {
            for (index, extra) in extras.enumerated() {
                guard let title = extra.categoryEn else {
                    return
                }
                sectionDic.append(index + 2)
                sectionTitles.append(title)
                if let data = extra.data {
                    extraListItems[index + 2] = data
                }
                print("dicList \(extraListItems.count)")
            }
            self.mCollectionView.reloadData()
        }
    }
}*/



/*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
 let headerView = UIView()
 headerView.backgroundColor = UIColor.lightGray
 
 let sectionLabel = UILabel(frame: CGRect(x: 8, y: 10, width:
 tableView.bounds.size.width, height: tableView.bounds.size.height))
 sectionLabel.font = UIFont(name: "Helvetica", size: 18)
 sectionLabel.textColor = UIColor.black
 sectionLabel.text = sections[section].type
 sectionLabel.sizeToFit()
 headerView.addSubview(sectionLabel)
 
 return headerView
 }*/
