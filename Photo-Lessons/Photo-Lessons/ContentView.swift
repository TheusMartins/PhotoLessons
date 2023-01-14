//
//  ContentView.swift
//  Photo-Lessons
//
//  Created by Matheus Martins on 14/01/23.
//

import SwiftUI
import Network_Layer

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
