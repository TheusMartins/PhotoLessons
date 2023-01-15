//
//  ContentView.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 14/01/23.
//

import SwiftUI
import LessonsList

struct LessonsListView: View {
    @StateObject var viewModel = LessonsViewModel()
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .isLoading:
                ProgressView()
            case let .feedLessons(lessons):
                List(lessons, id: \.id) { item in
                    NavigationLink {
                        EmptyView()
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
                        }
                    }

                    
                }
                .navigationTitle("Lessons")
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
