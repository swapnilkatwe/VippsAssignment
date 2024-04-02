//
//  VippsTestTests.swift
//  VippsTestTests
//
//  Created by SK on 21/01/24.
//

import XCTest
@testable import VippsTest
import Combine

class VippsTestTests: XCTestCase {
    var viewModel: WikipediaViewModel!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        viewModel = WikipediaViewModel(networkManager: MockNetworkAPIManager())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }

    func testgetCountForTopic() throws {
        let topicCount = viewModel.countForSearchedTopic(topicModel: TopicModel(parse: Parse(title: "test", pageid: 1, text: HtmlText(htmlFormat: "<div><p>Norway Norway norway<p> </div>"))), topic: "Norway")
        XCTAssertEqual(topicCount, 2)
    }
    
    // MOCK api call
    func testGetTopicResult() {
        let expectation = XCTestExpectation(description: "topic fetch")
        var cancelable: AnyCancellable?
        cancelable = viewModel.$count
            .dropFirst()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
        viewModel.fetchTopicCount(for: "Tennis") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, 13)
            case .failure(_):
                XCTAssert(false)
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
