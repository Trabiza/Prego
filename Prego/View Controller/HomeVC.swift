//
//  HomeVC.swift
//  Prego
//
//  Created by owner on 8/19/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    let nibCellName: String = "HomeCell"
    var mList: [String] = ["1.jpeg", "2.jpg", "3.jpg", "4.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollection()
        
        if let token = DefaultManager.getUserToken() {
            print("token is \(token)")
        }
    }
    
    func registerCollection(){
        mCollectionView.register(UINib(nibName: nibCellName, bundle: nil), forCellWithReuseIdentifier: nibCellName)
        pageControll.numberOfPages = mList.count
    }
}


extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: nibCellName , for: indexPath) as! HomeCell
        
        cell.seImage(url: mList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControll.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        let height = self.mCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
