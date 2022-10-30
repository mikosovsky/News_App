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
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let name: String
}

