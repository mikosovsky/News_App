//
//  WeatherViewController.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 29/10/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var currentWeatherView: UIView!
    @IBOutlet weak var weatherSlideView: WeatherSlideView!
    let locationManager: CLLocationManager = CLLocationManager()
    let weatherModel: WeatherModel = WeatherModel()
    var additionalWeathers: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManagerSetUp()
        weatherModel.delegate = self
        weatherModel.getWeatherData(city: "Poznan")
        weatherModel.getWeatherData(lat: "52.17", lon: "52.3")
        currentWeatherView.layer.cornerRadius = 20
        weatherSlideView.dataSource = self
        weatherSlideView.reloadData()
    }
    
    //func to set up locationManager
    func locationManagerSetUp() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            print("\(location.coordinate.latitude) \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherModelDelegate

extension WeatherViewController: WeatherModelDelegate {
    func didDecodedData(_ weatherData: WeatherData) {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: weatherData.sunset)
        additionalWeathers.append(weatherData)
        print(currentTime)
        print(weatherData.sunset)
        print(weatherData.cityName)
        weatherSlideView.reloadData()
    }
}

//MARK: - WeatherSlideViewDataSource

extension WeatherViewController: WeatherSlideViewDataSource {
    func returnArrayOfWeatherSingleView() -> [WeatherData] {
        return additionalWeathers
    }
}
