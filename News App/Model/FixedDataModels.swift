//
//  FixedDataModels.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 02/11/2022.
//

import Foundation

//MARK: - NewsArticleData

struct NewsArticleData {
    let source: String?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
}

//MARK: - WeatherData

struct WeatherData {
    let cityName: String
    let temp: Float
    let pressure: Int
    let humidity: Int
    let weatherType: String
    let weatherDescription: String
    let sunriseUTC: Int64
    let sunsetUTC: Int64
    let timezone: Int64
    var sunrise: Date {
        let sunriseInt = sunriseUTC + timezone
        let sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseInt))
        return sunrise
    }
    var sunset: Date {
        let sunsetInt = sunsetUTC + timezone
        let sunset = Date(timeIntervalSince1970: TimeInterval(sunsetInt))
        return sunset
    }
    let weatherID: Int
    var weatherImageName: String {
        switch weatherID {
        case 200...299:
            return "cloud.bolt.fill"
        case 300...399:
            return "cloud.drizzle.fill"
        case 500...599:
            return "cloud.rain.fill"
        case 600...699:
            return "cloud.snow.fill"
        case 700...799:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...809:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
}
