//
//  NewsModel.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 30/10/2022.
//

import Foundation

protocol NewsModelDelegate {
    func didDecodedData(_ newsArticleData:[NewsArticleData])
}

class NewsModel {
    
    var delegate: NewsModelDelegate?
    let urlString: String = "https://newsapi.org/v2/top-headlines?"
    let apiKey: String = "&apiKey=" + NewsApi.apiKey
    let requestModel: RequestModel
    
    func getNewsData() {
        let readyPhrase = "country=gb"
        Task {
            await requestModel.makeRequest(bodyString: readyPhrase)
        }
    }
    
    func getNewsData(phrase: String) {
        let readyPhrase = "q=" + phrase.replacingOccurrences(of: " ", with: "+")
        Task {
            await requestModel.makeRequest(bodyString: readyPhrase)
        }
        
    }
    
    // parsing data to codable class and then to class easy to use
    
    func parseJSON(_ data:Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(NewsDataModel.self, from: data)
            if decodedData.status == K.NewsApi.okStatus {
                let newsArticlesData = NDMtoNAD(decodedData)
                delegate?.didDecodedData(newsArticlesData)
            } else {
                
            }
            
            
        } catch {
            print(error)
        }
        
    }
    
    //Translator of NewsDataModel to [NewsArticleData]
    
    func NDMtoNAD(_ newsDataModel:NewsDataModel) -> [NewsArticleData] {
        
        var newsArticlesData: [NewsArticleData] = []
        newsDataModel.articles.forEach { article in
            let source = article.source.name
            let author = article.author
            let title = article.title
            let description = article.description
            let url = article.url
            let urlToImage = article.urlToImage
            let publishedAt = article.publishedAt
            let newsArticleData = NewsArticleData(source: source, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
            newsArticlesData.append(newsArticleData)
        }
        return newsArticlesData
        
    }
    
    init() {
        requestModel = RequestModel(apiKey: apiKey, urlString: urlString)
        requestModel.delegate = self
    }
}

//MARK: - RequestModelDelegate

extension NewsModel: RequestModelDelegate {
    
    func didGetData(_ data: Data) {
        
        parseJSON(data)
        
    }
    
}
