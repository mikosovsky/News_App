//
//  NewsWebViewController.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 07/11/2022.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}
