//
//  WeatherModel.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 09/11/2022.
//

import Foundation

protocol WeatherModelDelegate {
    func didDecodedData()
}

class WeatherModel {
    let requestModel: RequestModel
    let apiKey = "&appid=" + WeatherApi.apiKey
    let urlString = "https://api.openweathermap.org/data/2.5/weather?units=metric&"
    
    func getWeatherData(city: String) {
        let body = "q=" + city
        Task {
            await requestModel.makeRequest(bodyString: body)
        }
    }
    
    func getWeatherData(lat: String, lon: String) {
        
    }
    
    init() {
        requestModel = RequestModel(apiKey: apiKey, urlString: urlString)
        requestModel.delegate = self
    }
}

//MARK: - RequestModelDelegate

extension WeatherModel: RequestModelDelegate {
    
    func didGetData(_ data: Data) {
        print(String(data: data, encoding: .utf8)!)
    }
}
