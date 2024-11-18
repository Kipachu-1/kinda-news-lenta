//
//  NewsViewModel.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

import Foundation

class NewsViewModel {
    private(set) var articles: [Article] = []
       var articlesDidUpdate: (() -> Void)?
       var isLoading = false
       var currentPage = 1
       let pageSize = 20
       
       func fetchNews(loadMore: Bool = false) {
           guard !isLoading else { return }
           
           isLoading = true
           
           if !loadMore {
               currentPage = 1
               articles = []
           }
           
           NewsAPIService.shared.fetchNews(page: currentPage, pageSize: pageSize) { [weak self] result in
               guard let self = self else { return }
               
               defer { self.isLoading = false }
               
               switch result {
               case .success(let fetchedArticles):
                   if loadMore {
                       self.articles.append(contentsOf: fetchedArticles)
                   } else {
                       self.articles = fetchedArticles
                   }
                   
                   self.currentPage += 1
                   self.articlesDidUpdate?()
                   
               case .failure(let error):
                   print("Error fetching news: \(error)")
               }
           }
       }
    
    func toggleLike(for article: Article) {
        if let index = articles.firstIndex(where: { $0.url == article.url }) {
            articles[index].isLiked = LikedArticlesManager.shared.toggleLike(for: article)
            articlesDidUpdate?()
        }
    }
}
