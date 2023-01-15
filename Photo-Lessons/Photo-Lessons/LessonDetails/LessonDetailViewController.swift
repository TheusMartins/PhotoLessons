//
//  LessonDetailViewController.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 15/01/23.
//

import UIKit
import SwiftUI

struct SwiftUILessonDetailView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LessonDetailViewController {
        return LessonDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: LessonDetailViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = LessonDetailViewController
}

final class LessonDetailViewController: UIViewController {
    private let contentView: LessonDetailView = LessonDetailView(title: "This is a Test", description: "This is the description of the text")
    
    override func loadView() {
        view = contentView
    }
}
