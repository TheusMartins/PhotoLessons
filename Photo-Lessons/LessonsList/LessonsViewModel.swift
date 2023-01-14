//
//  LessonsViewModel.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

final class LessonsViewModel {
    private let service: LessonsService
    private let viewUpdater: (LessonsListStates) -> Void
    
    enum LessonsListStates {
        case isLoading(Bool)
        case feedLessons(LessonsModel)
        case showError(errorMessage: String)
    }
    
    init(service: LessonsService = LessonsServiceImplementation(),
         viewUpdater: @escaping (LessonsListStates) -> Void) {
        self.service = service
        self.viewUpdater = viewUpdater
        getLessons()
    }
    
    private func getLessons() {
        viewUpdater(.isLoading(true))
        service.getLessons(request: LessonsRequest.getLessons) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                self.viewUpdater(.feedLessons(model))
            case let .failure(error):
                self.viewUpdater(.showError(errorMessage: error.localizedDescription))
            }
            self.viewUpdater(.isLoading(false))
        }
    }
}
