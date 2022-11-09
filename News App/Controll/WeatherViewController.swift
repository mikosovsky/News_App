//
//  WeatherViewController.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 29/10/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    let locationManager: CLLocationManager = CLLocationManager()
    let weatherModel: WeatherModel = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManagerSetUp()
        weatherModel.delegate = self
        weatherModel.getWeatherData(city: "Poznan")
        weatherModel.getWeatherData(lat: "52.17", lon: "52.3")
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
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: weatherData.sunset)
        print(currentTime)
        print(weatherData.sunset)
    }
}
