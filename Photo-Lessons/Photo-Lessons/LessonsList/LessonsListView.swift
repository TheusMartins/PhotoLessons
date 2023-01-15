//
//  ContentView.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 14/01/23.
//

import SwiftUI
import LessonsList

struct LessonsListView: View {
    @StateObject private var viewModel = LessonsViewModel()
    
    init() {
        UINavigationBar.appearance().backgroundColor = .darkGray
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .isLoading:
                ProgressView()
            case let .feedLessons(lessons):
                List(lessons, id: \.id) { item in
                    NavigationLink {
                        SwiftUILessonDetailView(lesson: item)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: item.thumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                    .cornerRadius(4)
                                    .padding(.vertical, 4)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            
                            Text(item.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .lineLimit(3)
                                .foregroundColor(Color.white)
                        }
                        .background(Color.init(uiColor: UIColor.darkGray))
                    }
                    .background(Color.init(uiColor: UIColor.darkGray))
                    .listRowBackground(Color.init(uiColor: UIColor.darkGray))
                    .accentColor(Color.blue)
                }
                .padding(.all, -20)
                .navigationBarTitle("Lessons", displayMode: .automatic)
            case let .showError(errorMessage):
                Text(errorMessage)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsListView()
    }
}
