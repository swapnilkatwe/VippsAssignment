//
//  NetworkAPIManager.swift
//  WikiTopicSearch
//
//  Created by SK on 21/01/24.
//

import Foundation

struct AppConfig {

    static let shared = AppConfig()
    let baseURL = "https://en.wikipedia.org/w/api.php"
}


class NetworkAPIManager: NetworkService {

    private let appConfig: AppConfig

    init(appConfig: AppConfig = AppConfig.shared) {
        self.appConfig = appConfig
    }

    func fetchData(forURL url: URL,
                   queryParam: [URLQueryItem]?,
                   completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let request = buildRequest(url: url, queryParam: queryParam)

        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            self?.handleResponse(data: data,
                                 response: response,
                                 error: error,
                                 completion: completion)
        }.resume()
    }
}
