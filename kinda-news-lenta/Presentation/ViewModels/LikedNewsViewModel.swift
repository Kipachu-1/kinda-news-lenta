//
//  NewsViewModel.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

import Foundation

enum LikedNewsError: Error {
    case networkError(String)
    case noLikedArticles
}

class LikedNewsViewModel {
    private(set) var articles: [Article] = []
    var articlesDidUpdate: (() -> Void)?
    var didEncounterError: ((LikedNewsError) -> Void)?
    private(set) var isLoading = false
    var currentPage = 1
    let pageSize = 20
    
    
    func fetchNews(loadMore: Bool = false) {
        guard !isLoading else { return }
        
        isLoading = true
        
        if !loadMore {
            currentPage = 1
            articles = []
        }
        
        // Simulate fetching liked articles
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            // Get the liked articles from the manager
            let likedArticles = LikedArticlesManager.shared.getLikedArticles()
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if likedArticles.isEmpty {
                    // Notify that no liked articles are available
                    self.didEncounterError?(.noLikedArticles)
                } else {
                    // Update the articles and notify the UI
                    self.articles = likedArticles
                    self.articlesDidUpdate?()
                }
            }
        }
    }
    
    func toggleLike(for article: Article) {
        if let index = articles.firstIndex(where: { $0.url == article.url }) {
            articles[index].isLiked = LikedArticlesManager.shared.toggleLike(for: article)
            articles.removeAll { $0.url == article.url }
            articlesDidUpdate?()
        }
    }
}
