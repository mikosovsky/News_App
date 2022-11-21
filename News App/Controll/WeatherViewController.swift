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
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    let locationManager: CLLocationManager = CLLocationManager()
    let weatherModel: WeatherModel = WeatherModel()
    var additionalWeathers: [WeatherData] = []
    var downloadCurrentLocation: Bool = false
    var coordinations = ["lat":"","lon":""]
    var favCities = ["Poznan", "Chicago", "New+York"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManagerSetUp()
        weatherModelSetUp()
        currentWeatherView.layer.cornerRadius = 20
        weatherSlideView.dataSource = self
        
    }
    
    //func to set up locationManager
    func locationManagerSetUp() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    //func to set up weatherModel
    func weatherModelSetUp() {
        weatherModel.delegate = self
        weatherModel.getWeatherData(city: "Poznan")
        weatherModel.getWeatherData(lat: "52.17", lon: "52.3")
        weatherModel.getWeatherData(city: "New+York")
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            coordinations["lat"] = String(location.coordinate.latitude)
            coordinations["lon"] = String(location.coordinate.longitude)
            weatherModel.getWeatherData(lat: coordinations["lat"]!, lon: coordinations["lon"]!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherModelDelegate

extension WeatherViewController: WeatherModelDelegate {
    func didDecodedData(_ weatherData: WeatherData) {

        if weatherData.lat == coordinations["lat"] && weatherData.lon == coordinations["lon"]
        {
            print("Jestem tutaj")
            cityLabel.text = weatherData.cityName
            tempLabel.text = weatherData.tempString
            let config = UIImage.SymbolConfiguration.preferringMulticolor()
            let image = UIImage(systemName: weatherData.weatherImageName, withConfiguration: config)
            weatherImage.image = image
            sunriseTime.text = weatherData.sunriseTime
            sunsetTime.text = weatherData.sunsetTime
        }
        additionalWeathers.append(weatherData)
        weatherSlideView.reloadData()
    }
}

//MARK: - WeatherSlideViewDataSource

extension WeatherViewController: WeatherSlideViewDataSource {
    func returnArrayOfWeatherSingleView() -> [WeatherData] {
        return additionalWeathers
    }
}
