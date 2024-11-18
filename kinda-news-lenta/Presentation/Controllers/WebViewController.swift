//
//  WebViewController.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    private let webView: WKWebView
    private let urlString: String
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.tintColor = UIColor(hex: "#6048ff")
        return progressView
    }()
    
    init(urlString: String) {
        self.urlString = urlString
        self.webView = WKWebView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebPage()
    }
    
    private func setupUI() {
        view.addSubview(webView)
        view.addSubview(progressView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
//        // Navigation Controls
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: webView, action: #selector(WKWebView.goBack))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: webView, action: #selector(WKWebView.goForward))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissWebView))

       
        navigationItem.leftBarButtonItems = [doneButton]
        navigationItem.rightBarButtonItems = [forwardButton,backButton]
        
        // Progress Observation
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    @objc private func dismissWebView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadWebPage() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            progressView.isHidden = webView.estimatedProgress == 1
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
}
