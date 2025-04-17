//
//  ContentView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 09/04/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: ViewModel
    private var posts: [Posts] = []

        
    var body: some View {
        NavigationSplitView {
            List {
                ForEach($viewModel.postsArray, id: \.self) { $post in
                    let title = post.title ?? ""
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        Text("\(title)")
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                HStack {
                    Spacer()
                    ReactiveControl()
                    Spacer()
                }
            }
            .onAppear {
                viewModel.getPosts()
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(ViewModel())
}
