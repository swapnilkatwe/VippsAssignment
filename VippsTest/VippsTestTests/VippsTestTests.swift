//
//  VippsTestTests.swift
//  VippsTestTests
//
//  Created by SK on 21/01/24.
//

import XCTest
@testable import VippsTest

class VippsTestTests: XCTestCase {
    var viewModel: WikipediaViewModel!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        viewModel = WikipediaViewModel(networkManager: NetworkAPIManager(appConfig: AppConfig.shared))
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }

    func testgetCountForTopic() throws {
        let topicCount = viewModel.countForSearchedTopic(topicModel: TopicModel(parse: Parse(title: "test", pageid: 1, text: HtmlText(htmlFormat: "<div><p>Norway Norway norway<p> </div>"))), topic: "Norway")
        XCTAssertEqual(topicCount, 2)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
