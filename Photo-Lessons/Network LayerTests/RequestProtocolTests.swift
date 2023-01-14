//
//  RequestProtocolTests.swift
//  Network LayerTests
//
//  Created by Matheus Martins on 14/01/23.
//

import XCTest
import Network_Layer

final class RequestProtocolTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, spy) = createSUT()

        XCTAssertTrue(spy.requests.isEmpty)
    }
    
    func test_requestTwice_requestsDataFromURLTwice() {
        let (sut, spy) = createSUT()
        sut.requestData(requestInfos: RequestsResults.success) { _ in }
        sut.requestData(requestInfos: RequestsResults.success) { _ in }
        XCTAssertEqual(spy.requests.count, 2)
    }
    
    func test_request_successScenario() {
        let (sut, spy) = createSUT()
        
        let ext = expectation(description: "Wait for requestData completion")
        sut.requestData(requestInfos: RequestsResults.success) { result in
            switch result {
            case let .success((data, response)):
                XCTAssertNotNil(data)
                XCTAssertNotNil(response)
            case let .failure(error):
                XCTFail("expected success and got \(error) instead")
            }
            ext.fulfill()
        }
        XCTAssertEqual(spy.requests.count, 1)
        wait(for: [ext], timeout: 1.0)
    }
    
    func test_request_failureScenario() {
        let (sut, spy) = createSUT(isSuccessScenario: false)
        
        let ext = expectation(description: "Wait for requestData completion")
        sut.requestData(requestInfos: RequestsResults.failure) { result in
            switch result {
            case .success:
                XCTFail("expected success and got \(result) instead")
            case let .failure(error):
                XCTAssertNotNil(error)
            }
            ext.fulfill()
        }
        XCTAssertEqual(spy.requests.count, 1)
        wait(for: [ext], timeout: 1.0)
    }

    
    // Helpers
    func createSUT(isSuccessScenario: Bool = true, file: StaticString = #filePath, line: UInt = #line) -> (Request, RequestProtocolSpy) {
        let requestSpy = RequestProtocolSpy()
        requestSpy.shouldBeSuccess = isSuccessScenario
        let sut = Request(session: requestSpy)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(requestSpy, file: file, line: line)
        return (sut, requestSpy)
    }
}

enum RequestsResults {
    case success
    case failure
}

extension RequestsResults: RequestInfos {
    var endpoint: String {
        return "test-api/lessons"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        return [:]
    }
}
