//
//  WeatherSlideView.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 18/11/2022.
//

import UIKit

protocol WeatherSlideViewDataSource {
    func returnArrayOfWeatherSingleView() -> [WeatherData]
}

class WeatherSlideView: UIView {
    
    @IBOutlet weak var weatherSingleView: WeatherSingleView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var stackOfWeatherSingleView: UIView!
    
    var dataSource: WeatherSlideViewDataSource?
    private var weatherSingleViewArray: [WeatherData] = []
    private let nibName = "WeatherSlideView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        weatherSingleViewArray = dataSource?.returnArrayOfWeatherSingleView() ?? []
        print(weatherSingleViewArray.count)
        if weatherSingleViewArray.count == 0 {
            self.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        weatherSingleViewArray = dataSource?.returnArrayOfWeatherSingleView() ?? []
        print(weatherSingleViewArray.count)
        if weatherSingleViewArray.count == 0 {
            self.isHidden = true
        }
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func reloadData() {
        weatherSingleViewArray = dataSource?.returnArrayOfWeatherSingleView() ?? []
        print(weatherSingleViewArray.count)
        
        if weatherSingleViewArray.count == 0 {
            self.isHidden = true
        } else {
            self.isHidden = false
            setup()
        }
    }
    
    private func setupSingleView(indexPath: Int) {
        
        UIView.transition(with: stackOfWeatherSingleView, duration: 0.5, options: .transitionCrossDissolve) {
            [weak self] in
            self?.weatherSingleView.cityLabel.text = self?.weatherSingleViewArray[indexPath].cityName
            self?.weatherSingleView.tempLabel.text = self?.weatherSingleViewArray[indexPath].tempString
            let config = UIImage.SymbolConfiguration.preferringMulticolor()
            let image = UIImage(systemName: self?.weatherSingleViewArray[indexPath].weatherImageName ?? "sun.max.fill", withConfiguration: config)
            self?.weatherSingleView.weatherImage.image = image
        }

    }
    
    private func setup() {
        pageControl.numberOfPages = weatherSingleViewArray.count
        pageControl.currentPage = 0
        setupSingleView(indexPath: pageControl.currentPage)
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        if pageControl.currentPage > 0 {
            pageControl.currentPage -= 1
            setupSingleView(indexPath: pageControl.currentPage)
        }
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if pageControl.currentPage < pageControl.numberOfPages - 1 {
            pageControl.currentPage += 1
            setupSingleView(indexPath: pageControl.currentPage)
        }
    }
    
}
