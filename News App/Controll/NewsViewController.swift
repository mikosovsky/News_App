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
        searchTextFieldSetUp()
        newsTableViewSetUp()
        newsModelSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        newsModel.getNewsData()
    }
    
    // func to set up searchTextField
    func searchTextFieldSetUp() {
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height/2.0
        searchTextField.clipsToBounds = true
        searchTextField.borderStyle = .none
        searchTextField.setLeftPaddingPoints(searchTextField.frame.size.height/2.0)
        searchTextField.setRightPaddingPoints(searchTextField.frame.size.height/2.0)
        searchTextField.delegate = self
    }
    
    //func to set up newsModel
    func newsModelSetUp() {
        newsModel.delegate = self
        newsModel.getNewsData()
    }
    
    //func to set up newsTableView
    func newsTableViewSetUp() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        newsTableView.register(UINib(nibName: K.NewsTableView.cellNibName, bundle: nil), forCellReuseIdentifier: K.NewsTableView.cellIdentifier)
    }
    
    //func to pass data through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.cellToWeb {
            if let id = newsTableView.indexPathForSelectedRow?.row, let url = newsArticlesData[id].url {
                    let controller = segue.destination as! NewsWebViewController
                    controller.url = url
            }
        }
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
        newsTableView.reloadSections([0], with: .top)
        if newsArticlesData.count > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            newsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    
}

//MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news = newsArticlesData[indexPath.row]
        let cell = newsTableView.dequeueReusableCell(withIdentifier: K.NewsTableView.cellIdentifier, for: indexPath) as! NewsCell
        cell.titleLabel.text = news.title
        cell.descriptionLabel.text = news.description
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = newsArticlesData[indexPath.row].url {
            performSegue(withIdentifier: K.Segues.cellToWeb, sender: self)
        }
    }
}
