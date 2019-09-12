//
//  GuideVC.swift
//  Prego
//
//  Created by owner on 8/22/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import UIKit



class GuideVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    var slides: [SlideView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControll.numberOfPages = slides.count
        pageControll.currentPage = 0
        view.bringSubview(toFront: pageControll)
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        NavigationManager.toLogin(self)
    }
    
    @IBAction func skipAction(_ sender: Any) {
        NavigationManager.toLogin(self)
    }
    
    func createSlides() -> [SlideView] {
        
        let slide1:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide1.mImageView.image = UIImage(named: "ChooseFood.png")
        slide1.titleLabel.text = "Choose Food"
        slide1.descritionLabel.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."
        
        let slide2:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide2.mImageView.image = UIImage(named: "FastDelivery.png")
        slide2.titleLabel.text = "Fast Delivery"
        slide2.descritionLabel.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."
        
        let slide3:SlideView = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
        slide3.mImageView.image = UIImage(named: "TrackingOrder.png")
        slide3.titleLabel.text = "Tracking Order"
        slide3.descritionLabel.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [SlideView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }

}

extension GuideVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControll.currentPage = Int(pageIndex)
    }
}
