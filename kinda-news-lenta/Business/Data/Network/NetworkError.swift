//
//  NetworkError.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

enum NetworkError: Error {
    case invalidURL
    case networkFailure(Error)
    case decodingError
    case apiError(String)
}
