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
    }
    
    //func to set up locationManager
    func locationManagerSetUp() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherModel.getWeatherData(city: "Poznan")
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

