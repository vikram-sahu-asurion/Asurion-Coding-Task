//
//  PetDetailViewController.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 26/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit
import WebKit

class PetDetailViewController: UIViewController {
    
    var petURL = ""
    var petName = ""
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        
        // Set selected pet as title
        self.title = petName
        
        // Load the URL in Web View
        if let urlToLoad = URL(string: petURL) {
            let request = URLRequest(url: urlToLoad)
            webView.load(request)
        }
    }
}

extension PetDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
