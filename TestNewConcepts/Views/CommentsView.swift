//
//  CommentsView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 09/04/25.
//

import SwiftUI
import SwiftData

struct CommentsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: ViewModel
    private var posts: [Posts] = []

        
    var body: some View {
        NavigationSplitView {
            List {
                ForEach($viewModel.comments, id: \.self) { $comment in
                    let title = comment.name ?? ""
                    NavigationLink {
                        CommentDetailView(comment: comment)
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
                viewModel.getComments()
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
