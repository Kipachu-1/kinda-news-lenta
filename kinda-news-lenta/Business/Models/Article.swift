//
//  Article.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//
import Foundation

struct Article: Codable {
    let title: String
    let description: String?
    let urlToImage: String?
    let url: String
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case url
        case isLiked
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try? container.decode(String.self, forKey: .description)
        urlToImage = try? container.decode(String.self, forKey: .urlToImage)
        url = try container.decode(String.self, forKey: .url)
        isLiked = try container.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
    }
}

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
