//
//  LessonsViewModel.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

public final class LessonsViewModel: ObservableObject {
    private let service: LessonsService
    
    @Published public var state: LessonsListStates = .isLoading
    
    public enum LessonsListStates {
        case isLoading
        case feedLessons([LessonUIModel])
        case showError(errorMessage: String)
    }
    
    public init(service: LessonsService = LessonsServiceImplementation()) {
        self.service = service
        getLessons()
    }
    
    private func getLessons() {
        state = .isLoading
        service.getLessons(request: LessonsRequest.getLessons) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                self.feedLessons(lessons: model.uiModel)
            case let .failure(error):
                self.state = .showError(errorMessage: error.localizedDescription)
            }
        }
    }
    
    private func feedLessons(lessons: [LessonUIModel]) {
        DispatchQueue.main.async { self.state = .feedLessons(lessons) }
    }
    
    private func showError(errorMessage: String) {
        DispatchQueue.main.async { self.state = .showError(errorMessage: errorMessage) }
    }
}
