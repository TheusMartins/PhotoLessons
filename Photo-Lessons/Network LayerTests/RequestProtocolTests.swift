//
//  RequestProtocolTests.swift
//  Network LayerTests
//
//  Created by Matheus Martins on 14/01/23.
//

import XCTest
@testable import Network_Layer

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
    func createSUT(isSuccessScenario: Bool = true) -> (Request, RequestProtocolSpy) {
        let requestSpy = RequestProtocolSpy()
        requestSpy.shouldBeSuccess = isSuccessScenario
        let sut = Request(session: requestSpy)
        return (sut, requestSpy)
    }
}

final class RequestProtocolSpy: URLSession {
    var requests = [(request: URLRequest, completion: (Data?, URLResponse?, Error?) -> Void)]()
    
    var shouldBeSuccess = true {
        didSet {
            print("Pastel")
        }
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> URLSessionDataTask {
        let response: (Data?, URLResponse?, Error?) = shouldBeSuccess ? (Data("some data".utf8),
                                                                         URLResponse(url: request.url!, mimeType: "", expectedContentLength: 0, textEncodingName: nil),
                                                                         nil) :
                                                                        (nil, nil, NSError(domain: "Test", code: 1))
        requests.append((request, completionHandler))
        
        return URLSessionDataTaskMock {
            completionHandler(response.0, response.1, response.2)
        }
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
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
