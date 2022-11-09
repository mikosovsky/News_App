//
//  WeatherModel.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 09/11/2022.
//

import Foundation

protocol WeatherModelDelegate {
    func didDecodedData(_ weatherData: WeatherData)
}

class WeatherModel {
    let requestModel: RequestModel
    let apiKey = "&appid=" + WeatherApi.apiKey
    let urlString = "https://api.openweathermap.org/data/2.5/weather?units=metric&"
    var delegate: WeatherModelDelegate?
    
    func getWeatherData(city: String) {
        let body = "q=" + city
        Task {
            await requestModel.makeRequest(bodyString: body)
        }
    }
    
    func getWeatherData(lat: String, lon: String) {
        let body = "lat=" + lat + "&lon=" + lon
        Task {
            await requestModel.makeRequest(bodyString: body)
        }
    }
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            decoder.dateDecodingStrategy = .secondsSince1970
            let decodedData = try decoder.decode(WeatherDataModel.self, from: data)
            let weatherData = WDMtoWM(decodedData)
            delegate?.didDecodedData(weatherData)
            
        } catch {
            print(error)
        }
    }
    
    func WDMtoWM(_ weatherDataModel: WeatherDataModel) -> WeatherData {
        let cityName = weatherDataModel.name
        let temp = weatherDataModel.main.temp
        let humidity = weatherDataModel.main.humidity
        let pressure = weatherDataModel.main.pressure
        let weatherID = weatherDataModel.weather.first?.id
        let weatherDescription = weatherDataModel.weather.first?.description
        let weatherType = weatherDataModel.weather.first?.main
        let sunset = weatherDataModel.sys.sunset
        let sunrise = weatherDataModel.sys.sunrise
        let weatherData = WeatherData(cityName: cityName, temp: temp, pressure: pressure, humidity: humidity, weatherType: weatherType!, weatherDescription: weatherDescription!, sunrise: sunrise, sunset: sunset, weatherID: weatherID!)
        return weatherData
    }
    
    init() {
        requestModel = RequestModel(apiKey: apiKey, urlString: urlString)
        requestModel.delegate = self
    }
}

//MARK: - RequestModelDelegate

extension WeatherModel: RequestModelDelegate {
    
    func didGetData(_ data: Data) {
        parseJSON(data)
    }
}
