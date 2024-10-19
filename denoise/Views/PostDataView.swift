//
//  PostDataView.swift
//  denoise
//
//  Created by Elia Salerno on 07.10.2024.
//

import SwiftUI

struct PostDataView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var newPostTitle: String = ""
    @State private var newPostBody: String = ""
    @State private var userId: Int = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("New Post")) {
                        TextField("Enter post title", text: $newPostTitle)
                            .autocapitalization(.none)
                        TextField("Enter post body", text: $newPostBody)
                            .autocapitalization(.none)
                        Stepper(value: $userId, in: 1...10) {
                            Text("User ID: \(userId)")
                        }
                    }
                    
                    Button(action: {
                        let newPost = PostItem(
                            id: Int.random(in: 1...1000), // Normally, ID is assigned by the server
                            title: newPostTitle,
                            body: newPostBody,
                            userId: userId
                        )
                        Task {
                            await networkManager.postData(urlString: "https://jsonplaceholder.typicode.com/posts", payload: newPost)
                        }
                    }) {
                        Text("Post Data")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding()
                
                if !networkManager.posts.isEmpty {
                    List(networkManager.posts, id: \.id) { post in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("ID: \(post.id)")
                                .font(.subheadline)
                            Text("Title: \(post.title)")
                                .font(.headline)
                            Text("Body: \(post.body)")
                                .font(.body)
                            Text("User ID: \(post.userId)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Post New Data")
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
