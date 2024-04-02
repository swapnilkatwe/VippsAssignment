//
//  MockNetworkAPIManager.swift
//  WikiTopicSearchTests
//
//  Created by SK on 07/02/24.
//

import Foundation
@testable import WikiTopicSearch
final class MockNetworkAPIManager: NetworkService {

    func fetchData(forURL url: URL, queryParam: [URLQueryItem]?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let path = Bundle.main.url(forResource: "WikiResponse", withExtension: "json") else {
            fatalError("json file error")
        }
        do {
            let data = try Data(contentsOf: path)
            return completion(.success(data))
        } catch {
            return completion(.failure(.noData))
        }
    }
}


