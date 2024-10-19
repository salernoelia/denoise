//
//  FetchDataView.swift
//  denoise
//
//  Created by Elia Salerno on 07.10.2024.
//

import SwiftUI

struct FetchDataView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let todo = networkManager.todoItem {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ID: \(todo.id)")
                            .font(.subheadline)
                        Text("Title: \(todo.title)")
                            .font(.headline)
                        Text("Completed: \(todo.completed ? "Yes" : "No")")
                            .font(.body)
                    }
                    .padding()
                } else {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationTitle("Todo Item")
            .onAppear {
                Task {
                    await networkManager.fetchTodoItem(urlString: "https://jsonplaceholder.typicode.com/todos/1")
                }
            }
            .alert(isPresented: Binding<Bool>(
                get: { networkManager.errorMessage != nil },
                set: { _ in networkManager.errorMessage = nil }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(networkManager.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
