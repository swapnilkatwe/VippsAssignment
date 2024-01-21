//
//  WikipediaViewModel.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import Foundation

protocol WikipediaService: DataParsing {

    func fetchTopicCount(for topic: String,
                         completion: @escaping (Result<Int, NetworkError>) -> Void)
}

class WikipediaViewModel: ObservableObject, WikipediaService {
    
    @Published var topic: String = ""
    @Published var count: Int = 0
    
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService = NetworkAPIManager()) {
        self.networkManager = networkManager
    }
    
    func fetchTopicCount(for topic: String, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        
        let queryParams = [
            URLQueryItem(name: "action", value: "parse"),
            URLQueryItem(name: "section", value: "0"),
            URLQueryItem(name: "prop", value: "text"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "page", value: topic),
        ]
        
        guard let baseURL = URL(string: AppConfig.shared.baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let url = baseURL.appendingQueryParameters(queryParams)
        
        networkManager.fetchData(forURL: url, queryParam: queryParams) { [weak self] result in
            guard let _self = self else { return }
            
            switch result {
            case .success(let data):
                _self.parseTopic(searchTopic: topic, data: data) { result in
                    switch result {
                    case .success(let searchedCount):
                        completion(.success(searchedCount))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//MARK: - Parsing Result
private extension WikipediaViewModel {

    private func parseTopic(searchTopic: String,
                            data: Data,
                            completion: @escaping (Result<Int, NetworkError>) -> Void) {
        let parsedResult = parseData(data)
        switch parsedResult {
            case .success(let topicModels):
                let searchedCount = countForSearchedTopic(topicModel: topicModels, topic: searchTopic)
                DispatchQueue.main.async {
                    self.count = searchedCount
                }
                completion(.success(searchedCount))

            case .failure(let error):
                DispatchQueue.main.async {
                    self.count = 0
                }
                completion(.failure(error))
        }
    }
}

//MARK: - Helper methods
extension WikipediaViewModel {

    func countForSearchedTopic(topicModel: TopicModel, topic: String) -> Int {

        guard isValidHtmlString(topicModel.parse.text.htmlFormat),
              let attributedText = topicModel.parse.text.htmlFormat.attributedHtmlString
        else { return 0 }

        let stringComponents = attributedText.string.components(separatedBy: .whitespacesAndNewlines)
        let topics = stringComponents.filter { $0 == topic }
        return topics.count
    }

    private func isValidHtmlString(_ value: String) -> Bool {
        guard !value.isEmpty else { return false }

        return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }
}
