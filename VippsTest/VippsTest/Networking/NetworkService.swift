//
//  NetworkService.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import Foundation

enum NetworkError: Error {

    case apiError(String)
    case invalidResponse
    case httpError(Int)
    case noData
    case invalidURL
}


protocol NetworkService {
    func fetchData(forURL url: URL,
                   queryParam: [URLQueryItem]?,
                   completion: @escaping (Result<Data, NetworkError>) -> Void)
}

extension NetworkService {
    
    // Request
    func buildRequest(url: URL,
                      method: String = "GET",
                      queryParam: [URLQueryItem]? = nil) -> URLRequest {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryParam
        var request = URLRequest(url: components?.url ?? url)
        request.httpMethod = method
        
        return request
    }
    
    // Handle Response
    func handleResponse(data: Data?,
                        response: URLResponse?,
                        error: Error?,
                        completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard error == nil else {
            if let error = error?.localizedDescription {
                completion(.failure(NetworkError.apiError(error)))
            }
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NetworkError.httpError(httpResponse.statusCode)))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkError.noData))
            return
        }

        completion(.success(data))
    }
}
