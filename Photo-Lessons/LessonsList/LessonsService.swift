//
//  LessonsService.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

import Network_Layer

enum LessonsListErrors: Error {
    case invalidData
}

public protocol LessonsService {
    func getLessons(request: RequestInfos,
                    completion: @escaping (Result<LessonsModel, Error>) -> Void)
}

public final class LessonsServiceImplementation: LessonsService {
    private let requester: Request
    
    public init(requester: Request = Request()) {
        self.requester = requester
    }
    
    public func getLessons(request: RequestInfos, completion: @escaping (Result<LessonsModel, Error>) -> Void) {
        requester.requestData(requestInfos: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data, _)):
                guard let lessons = self.mapDataToLessons(data: data) else {
                    completion(.failure(LessonsListErrors.invalidData))
                    return
                }
                completion(.success(lessons))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapDataToLessons(data: Data) -> LessonsModel? {
        guard let lessons = try? JSONDecoder().decode(LessonsModel.self, from: data) else { return nil }
        return lessons
    }
}
