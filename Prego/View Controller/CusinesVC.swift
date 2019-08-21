//
//  CusinesVC.swift
//  Prego
//
//  Created by owner on 8/21/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class CusinesVC: UIViewController {

    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    let subCusinesSegue: String = "subCusinesSegue"
    let nibCellName: String = "CusinesCell"
    var mList: [String] = ["first.jpg", "second.jpg", "third.jpeg",
                           "first.jpg", "second.jpg", "third.jpeg",
                           "first.jpg", "second.jpg", "third.jpeg",
                           "first.jpg", "second.jpg", "third.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        setUI()
        registerCollection()
    }
    
    func setUI(){
        hideStatusBarLine()
        Utilits.cornerLeftRight(view: mView)
    }
    
    func registerCollection(){
        mCollectionView.register(UINib(nibName: nibCellName, bundle: nil), forCellWithReuseIdentifier: nibCellName)
    }

}

extension CusinesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CusinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: nibCellName , for: indexPath) as! CusinesCell
        cell.shadowAndBorderForCell(cell: cell)
        cell.seImage(url: mList[indexPath.row])
        cell.titleLabel.text = "Sandwiches"
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
        performSegue(withIdentifier: subCusinesSegue, sender: nil)
    }
}
