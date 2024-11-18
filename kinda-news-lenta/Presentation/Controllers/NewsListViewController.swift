//
//  NewsListViewController.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

import UIKit
import SnapKit
import Kingfisher

class NewsListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
      

        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchNews()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Table View Setup
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(NewsArticleCell.self, forCellReuseIdentifier: "NewsArticleCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    private func bindViewModel() {
        viewModel.articlesDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleCell", for: indexPath) as? NewsArticleCell else {
            return UITableViewCell()
        }
        
        let article = viewModel.articles[indexPath.row]
        cell.configure(with: article)
        
        cell.likeButtonTapped = { [weak self] in
            self?.viewModel.toggleLike(for: article)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let position = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let scrollViewHeight = scrollView.frame.size.height
            
            if position > contentHeight - scrollViewHeight {
                // Check if not already loading
                guard !viewModel.isLoading else { return }
                
                // Load more articles
                viewModel.fetchNews(loadMore: true)
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        let webVC = WebViewController(urlString: article.url)
        navigationController?.pushViewController(webVC, animated: true)
    }
}
