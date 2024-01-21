//
//  DataParsing.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import Foundation

protocol DataParsing {
    func parseData(_ data: Data) -> Result<TopicModel, NetworkError>
}

extension DataParsing {
    
    func parseData(_ data: Data) -> Result<TopicModel, NetworkError> {
        do {
            let result  = try JSONDecoder().decode(TopicModel.self, from: data)
            return .success(result)
        } catch {
            debugPrint("Error parsing data: \(error)")
            return .failure(.apiError("Error Parcing Data"))
        }
    }
}
