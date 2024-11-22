//
//  LikedArticlesManager.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

import Foundation

class LikedArticlesManager {
    static let shared = LikedArticlesManager()
    private let defaults = UserDefaults.standard
    private let likedArticlesKey = "likedArticles"
    
    func saveLikedArticle(_ article: Article)  {
        var likedArticles = getLikedArticles()
        
        // Check if the article is already liked
        guard !likedArticles.contains(where: { $0.url == article.url }) else {
            print("Article already liked.")
            return
        }
        
        // Mark the article as liked and save
        var likedArticle = article
        likedArticle.isLiked = true
        
        likedArticles.append(likedArticle)
        saveArticles(likedArticles)
        
    }

    func removeLikedArticle(_ article: Article) {
        var likedArticles = getLikedArticles()
        likedArticles.removeAll { $0.url == article.url }
        saveArticles(likedArticles)
    }
    
    func getLikedArticles() -> [Article] {
        guard let data = defaults.data(forKey: likedArticlesKey),
              let articles = try? JSONDecoder().decode([Article].self, from: data) else {
            return []
        }
        return articles
    }
    
    func isArticleLiked(_ article: Article) -> Bool {
        return getLikedArticles().contains { $0.url == article.url }
    }
    
    private func saveArticles(_ articles: [Article]) {
        guard let data = try? JSONEncoder().encode(articles) else { return }
        defaults.set(data, forKey: likedArticlesKey)
    }
    
    func toggleLike(for article: Article) -> Bool {
        if isArticleLiked(article) {
            removeLikedArticle(article)
            return false
        } else {
            saveLikedArticle(article)
            return true
        }
    }
}
