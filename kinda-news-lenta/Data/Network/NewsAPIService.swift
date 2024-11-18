//
//  NewsAPIService.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//
import Foundation
import Alamofire

class NewsAPIService {
    static let shared = NewsAPIService()
    private let baseURL = "https://newsapi.org/v2"
    private let apiKey = Config.NewsAPIKey
    
    func fetchNews(
        category: String = "technology",
        completion: @escaping (Result<[Article], NetworkError>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/top-headlines") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let parameters: Parameters = [
            "apiKey": apiKey,
            "country": "us",
            "category": category
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    completion(.success(newsResponse.articles))
                case .failure(let error):
                    completion(.failure(.networkFailure(error)))
                }
            }
    }
    
    func fetchNews(
        page: Int = 1,
        pageSize: Int = 20,
        completion: @escaping (Result<[Article], NetworkError>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/top-headlines") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let parameters: Parameters = [
            "apiKey": apiKey,
            "country": "us",
            "page": page,
            "pageSize": pageSize
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let newsResponse):
                    completion(.success(newsResponse.articles))
                case .failure(let error):
                    completion(.failure(.networkFailure(error)))
                }
            }
    }
}
