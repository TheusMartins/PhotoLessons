//
//  LessonDetailView.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 15/01/23.
//

import UIKit

final class LessonDetailView: UIView {
    private lazy var lessonImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lessonTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lessonDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .subheadline, compatibleWith: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextLessonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next lesson", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(title: String, description: String) {
        super.init(frame: .zero)
        self.lessonTitle.text = title
        self.lessonDescription.text = description
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addSubview(lessonImage)
        addSubview(playButton)
        addSubview(lessonTitle)
        addSubview(lessonDescription)
        addSubview(nextLessonButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            lessonImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            lessonImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            lessonImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            playButton.centerXAnchor.constraint(equalTo: lessonImage.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: lessonImage.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            
            lessonTitle.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 16),
            lessonTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lessonTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            lessonDescription.topAnchor.constraint(equalTo: lessonTitle.bottomAnchor, constant: 16),
            lessonDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lessonDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            nextLessonButton.heightAnchor.constraint(equalToConstant: 40),
            nextLessonButton.topAnchor.constraint(equalTo: lessonDescription.bottomAnchor, constant: 16),
            nextLessonButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func extraConfigs() {
        backgroundColor = .darkGray
    }
    
    private func setupViewConfiguration() {
        setViewHierarchy()
        setConstraints()
        extraConfigs()
    }
}
