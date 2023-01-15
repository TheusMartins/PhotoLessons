//
//  LessonDetailViewController.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 15/01/23.
//

import UIKit
import SwiftUI

struct LessonDetailView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LessonDetailViewController {
        return LessonDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: LessonDetailViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = LessonDetailViewController
}

final class LessonDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
