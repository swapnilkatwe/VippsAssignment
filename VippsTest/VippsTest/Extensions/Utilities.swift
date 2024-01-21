//
//  Utilities.swift
//  VippsTest
//
//  Created by SK on 21/01/24.
//

import Foundation

extension String {

    var attributedHtmlString: NSAttributedString? {
        try? NSAttributedString(
            data: Data(utf8),
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
    }
}

extension URL {
    func appendingQueryParameters(_ parameters: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters
        return components?.url ?? self
    }
}
