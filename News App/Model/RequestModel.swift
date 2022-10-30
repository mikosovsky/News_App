//
//  RequestModel.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 30/10/2022.
//

import Foundation

protocol RequestModelDelegate {
    func didGetData(_ data:Data)
}

class RequestModel {
    
    let apiKey: String
    let urlString: String
    
    var delegate: RequestModelDelegate?
    
    func makeRequest(bodyString: String) async {
        
        let urlString = urlString + "&apiKey=" + apiKey
        let url = URL(string: urlString)!
        let ses = URLSession(configuration: .default)
        do {
            let (data, _) = try await ses.data(from: url)
            delegate?.didGetData(data)
        } catch {
            print(error)
        }
    }
    
    init(apiKey: String, urlString: String) {
        self.apiKey = apiKey
        self.urlString = urlString
    }
}
