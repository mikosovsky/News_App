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
        if locationManager.authorizationStatus == CLAuthorizationStatus.denied {
            let alert = UIAlertController(title: "We need your localization to show current weather", message: "If you want to give us access to your localization press \"Go to settings\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            alert.addAction(UIAlertAction(title: "Go to settings", style: .default, handler: { alert in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            self.present(alert, animated: true)
        }
    }
    
    //func to set up weatherModel
    func weatherModelSetUp() {
        weatherModel.delegate = self
        weatherModel.getWeatherData(city: "Poznan")
        weatherModel.getWeatherData(lat: "52.17", lon: "52.3")
        weatherModel.getWeatherData(city: "New+York")
    }

    
    @IBAction func settingsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.weatherToSettings, sender: nil)
    }
    
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.requestLocation()
        }
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
        //Setting weather in current localization
        if weatherData.lat == coordinations["lat"] && weatherData.lon == coordinations["lon"]
        {
            cityLabel.text = weatherData.cityName
            tempLabel.text = weatherData.tempString
            let config = UIImage.SymbolConfiguration.preferringMulticolor()
            let image = UIImage(systemName: weatherData.weatherImageName, withConfiguration: config)
            weatherImage.image = image
            sunriseTime.text = weatherData.sunriseTime
            sunsetTime.text = weatherData.sunsetTime
        }
        //Checking for duplicated place in array
        var sameCity = false
        additionalWeathers.forEach { weather in
            if weather.cityName == weatherData.cityName {
                sameCity = true
            }
        }
        if sameCity == false {
            additionalWeathers.append(weatherData)
            weatherSlideView.reloadData()
        }
        
    }
}

//MARK: - WeatherSlideViewDataSource

extension WeatherViewController: WeatherSlideViewDataSource {
    func returnArrayOfWeatherSingleView() -> [WeatherData] {
        return additionalWeathers
    }
}
