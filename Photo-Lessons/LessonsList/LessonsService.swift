//
//  LessonsService.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

import Network_Layer

public protocol LessonsService {
    func getLessons(request: RequestInfos,
                    completion: @escaping (Result<[LessonsModel], Error>) -> Void)
}

final class LessonsServiceImplementation: LessonsService {
    private let requester: Request
    
    init(requester: Request = Request()) {
        self.requester = requester
    }
    
    func getLessons(request: RequestInfos, completion: @escaping (Result<[LessonsModel], Error>) -> Void) {
        requester.requestData(requestInfos: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data, _)):
                completion(.success(self.mapDataToLessons(data: data)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapDataToLessons(data: Data) -> [LessonsModel] {
        guard let lessons = try? JSONDecoder().decode([LessonsModel].self, from: data) else { return [] }
        return lessons
    }
}
