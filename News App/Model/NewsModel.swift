//
//  NewsModel.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 30/10/2022.
//

import Foundation

protocol NewsModelDelegate {
    func didDecodedData(_ newsData:NewsDataModel)
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
    
    func parseJSON(_ data:Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(NewsDataModel.self, from: data)
            delegate?.didDecodedData(decodedData)
            
            
        } catch {
            print(error)
        }
        
    }
    
    init() {
        self.requestModel = RequestModel(apiKey: apiKey, urlString: urlString)
        requestModel.delegate = self
    }
}

extension NewsModel: RequestModelDelegate {
    
    func didGetData(_ data: Data) {
        
        parseJSON(data)
        
    }
    
}
