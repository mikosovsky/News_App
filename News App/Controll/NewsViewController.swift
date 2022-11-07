//
//  ViewController.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 28/10/2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var newsTableView: UITableView!

    let newsModel: NewsModel = NewsModel()
    var newsArticlesData: [NewsArticleData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchTextField.delegate = self
        newsModel.delegate = self
        newsTableView.dataSource = self
        newsModel.getNewsData()
    }
    
    
    
}

//MARK: - UITextFieldDelegate

extension NewsViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let phrase = textField.text {
            newsModel.getNewsData(phrase: phrase)
        }
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
}

//MARK: - NewsModelDelegate

extension NewsViewController: NewsModelDelegate {
    
    func didDecodedData(_ newsArticlesData: [NewsArticleData]) {
        
        self.newsArticlesData = newsArticlesData
        print(newsArticlesData)
        newsTableView.reloadData()
        
    }
    
    
}

//MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = newsArticlesData[indexPath.row].title
        return cell
    }
    
}
