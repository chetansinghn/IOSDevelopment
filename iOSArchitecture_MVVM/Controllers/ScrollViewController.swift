//
//  ScrollViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 04/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var slides:[slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                scrollView.delegate = self
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage=0
        view.bringSubview(toFront: pageControl)
    }
    
    func setupSlideScrollView(slides : [slide]) {
            scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
            scrollView.isPagingEnabled = true
            
            for i in 0 ..< slides.count {
                slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(slides[i])
            }
      
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        
               let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
                let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
               
               let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
               let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }

               
    }
        



        func createSlides() -> [slide] {

                let slide1:slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! slide
                slide1.imageView.image = UIImage(named: "ic_onboarding_1")
                slide1.imageTitle.text = "A real-life bear"
                slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
                
                let slide2:slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! slide
                slide2.imageView.image = UIImage(named: "ic_onboarding_2")
                slide2.imageTitle.text = "A real-life bear"
                slide2.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
                
                let slide3:slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! slide
                slide3.imageView.image = UIImage(named: "ic_onboarding_3")
                slide3.imageTitle.text = "A real-life bear"
                slide3.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
                
                let slide4:slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! slide
                slide4.imageView.image = UIImage(named: "ic_onboarding_4")
                slide4.imageTitle.text = "A real-life bear"
                slide4.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
                
                
                let slide5:slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! slide
                slide5.imageView.image = UIImage(named: "ic_onboarding_5")
                slide5.imageTitle.text = "A real-life bear"
                slide5.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
                
                return [slide1, slide2, slide3, slide4, slide5]
            }

    }
}
