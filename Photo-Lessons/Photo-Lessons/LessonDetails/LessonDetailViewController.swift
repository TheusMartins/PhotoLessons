//
//  LessonDetailViewController.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 15/01/23.
//

import UIKit
import SwiftUI
import LessonsList

struct SwiftUILessonDetailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = LessonDetailViewController
    private let lesson: LessonUIModel
    
    init(lesson: LessonUIModel) {
        self.lesson = lesson
    }
    
    func makeUIViewController(context: Context) -> LessonDetailViewController {
        return LessonDetailViewController(lesson: lesson)
    }
    
    func updateUIViewController(_ uiViewController: LessonDetailViewController, context: Context) {
        
    }
}

final class LessonDetailViewController: UIViewController {
    private let contentView: LessonDetailView
    
    init(lesson: LessonUIModel) {
        self.contentView = LessonDetailView(lesson: lesson)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
}
