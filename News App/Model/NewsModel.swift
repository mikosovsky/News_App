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
    let apiKey: String
    let requestModel: RequestModel
    
    func parseJSON(_ data:Data) {
        
        let decoder = JSONDecoder()
        
        do {
            print(data)
            let decodedData = try decoder.decode(NewsDataModel.self, from: data)
            delegate?.didDecodedData(decodedData)
            
            
        } catch {
            print(error)
        }
        
    }
    
    init(apiKey: String) {
        self.apiKey = apiKey
        self.requestModel = RequestModel(apiKey: apiKey, urlString: urlString)
        requestModel.delegate = self
    }
}

extension NewsModel: RequestModelDelegate {
    
    func didGetData(_ data: Data) {
        
        parseJSON(data)
        
    }
    
}
