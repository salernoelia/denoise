//
//  NetworkManager.swift
//  denoise
//
//  Created by Elia Salerno on 07.10.2024.
//

import Foundation
import SwiftUI

struct TodoItem: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct PostItem: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}



class NetworkManager: ObservableObject {
    @Published var todoItem: TodoItem?
    @Published var posts: [PostItem] = []
    @Published var errorMessage: String? = nil
    
    func fetchTodoItem(urlString: String) async {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedItem = try JSONDecoder().decode(TodoItem.self, from: data)
            DispatchQueue.main.async {
                self.todoItem = decodedItem
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func postData(urlString: String, payload: PostItem) async {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encodedData = try JSONEncoder().encode(payload)
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            let response = try JSONDecoder().decode(PostItem.self, from: data)
            DispatchQueue.main.async {
                self.posts.append(response)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
