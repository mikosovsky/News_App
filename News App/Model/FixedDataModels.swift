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
