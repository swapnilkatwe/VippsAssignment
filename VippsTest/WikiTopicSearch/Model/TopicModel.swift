//
//  TopicModel.swift
//  WikiTopicSearch
//
//  Created by SK on 21/01/24.
//

import Foundation

struct TopicModel: Codable {
    let parse: Parse

}
// MARK: - Parse
struct Parse: Codable {

    let title: String
    let pageid: Int
    let text: HtmlText
}

// MARK: - Text
struct HtmlText: Codable {

    let htmlFormat: String

    enum CodingKeys: String, CodingKey {
        case htmlFormat = "*"
    }
}
