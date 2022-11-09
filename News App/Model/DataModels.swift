//
//  DataModels.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 30/10/2022.
//

import Foundation

//MARK: - NewsDataModel

struct NewsDataModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let name: String?
}

//MARK: - WeatherDataModel

struct WeatherDataModel: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let name: String
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Float
    let pressure: Int
    let humidity: Int
}

struct Sys: Codable {
    let sunrise: Date
    let sunset: Date
}
