//
//  LessonsViewModelTests.swift
//  LessonsListTests
//
//  Created by Matheus Martins on 14/01/23.
//

import XCTest
import Network_Layer
@testable import LessonsList

final class LessonsViewModelTests: XCTestCase {

    func test_shouldRequestLessonsOnInit() {
        // Given + When
        let spy = LessonsViewServiceSpy()
        let _ = LessonsViewModel(service: spy) { _ in }
        
        XCTAssertEqual(spy.numberOfCalls, 1)
    }
    
    func test_behaviorOnSuccessScenario() {
        // Given + When
        var loadingStates: [Bool] = []
        let spy = LessonsViewServiceSpy()
        let exp = expectation(description: "Waiting for feedLessons state")
        let exp2 = expectation(description: "Waiting for isLoading states")
        exp2.expectedFulfillmentCount = 2
        let _ = LessonsViewModel(service: spy) { viewState in
            switch viewState {
            case let .isLoading(isLoading):
                loadingStates.append(isLoading)
                exp2.fulfill()
            case let .feedLessons(model):
                XCTAssertEqual(model.count, 2)
                XCTAssertEqual(model.last?.name, "Lesson 2")
                exp.fulfill()
            case .showError:
                XCTFail("Expected success scenario but got \(viewState) instead")
            }
        }
        
        XCTAssertEqual(spy.numberOfCalls, 1)
        XCTAssertEqual(loadingStates, [true, false])
        wait(for: [exp, exp2], timeout: 1.0)
    }
    
    func test_behaviorOnFailingScenario() {
        // Given + When
        var loadingStates: [Bool] = []
        let spy = LessonsViewServiceSpy()
        spy.shouldThrowError = true
        let exp = expectation(description: "Waiting for error state")
        let exp2 = expectation(description: "Waiting for isLoading states")
        exp2.expectedFulfillmentCount = 2
        let _ = LessonsViewModel(service: spy) { viewState in
            switch viewState {
            case let .isLoading(isLoading):
                loadingStates.append(isLoading)
                exp2.fulfill()
            case .feedLessons:
                XCTFail("Expected failure scenario but got \(viewState) instead")
            case let .showError(error):
                XCTAssertNotNil(error)
                exp.fulfill()
            }
        }
        
        XCTAssertEqual(spy.numberOfCalls, 1)
        XCTAssertEqual(loadingStates, [true, false])
        wait(for: [exp, exp2], timeout: 1.0)
    }
}

final class LessonsViewServiceSpy: LessonsService {
    var shouldThrowError = false
    var numberOfCalls = 0
    func getLessons(request: RequestInfos,
                    completion: @escaping (Result<LessonsModel, Error>) -> Void) {
        numberOfCalls += 1
        shouldThrowError ? completion(.failure(NSError(domain: "Test", code: 1))) :
        completion(.success(LessonsModel(lessons: [
                Lesson(id: 0, name: "Lesson 1", thumbnail: "https://a-url.com", videoURL: "https://another-url.com"),
                Lesson(id: 1, name: "Lesson 2", thumbnail: "https://a-url.com", videoURL: "https://another-url.com"),
            ]))
        )
    }
}
