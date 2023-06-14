//
//  WebViewController.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import UIKit
import WebKit
import SwiftUI

class WebViewController: UIViewController {
    
    private var webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
   
    @State private var isLoading = false
    
    private let url: URL
    
    init(url: URL, title: String) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
       // view.addSubview(webView)
        webView.load(URLRequest(url: url))
        configureButtons ()
        
        //self.view.addSubview(self.createSpinnerFooter())
        loadNetworkWebView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func loadNetworkWebView () {
        isLoading = true
        self.view.addSubview(self.createSpinnerFooter())
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            self.isLoading = false
            self.view.addSubview(self.webView)
        }
    }
    
    private func configureButtons () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    
    @objc private func didTapDone () {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRefresh () {
        webView.load(URLRequest(url: url))
    }
    
}
