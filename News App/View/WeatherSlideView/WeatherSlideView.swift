//
//  WeatherSlideView.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 18/11/2022.
//

import UIKit

class WeatherSlideView: UIView {

    @IBOutlet weak var pageControl: UIPageControl!
    let nibName = "WeatherSlideView"
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
        }
        
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }

    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        if pageControl.currentPage > 0 {
            pageControl.currentPage -= 1
        }
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if pageControl.currentPage < pageControl.numberOfPages - 1 {
            pageControl.currentPage += 1
        }
    }
    
}
