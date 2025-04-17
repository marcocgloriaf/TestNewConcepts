//
//  DetailView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 16/04/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: Posts
    var body: some View {
            let title = post.title ?? ""
            let body = post.body ?? ""
        LazyVStack(alignment: .leading) {
                Text("User ID: \(post.userId ?? 0)")
                    .multilineTextAlignment(.center)
            Spacer(minLength: 20)
                Text("Title:  \(title)")
                    .multilineTextAlignment(.leading)
            Spacer(minLength: 20)
                Text("Body:  \(body)")
                    .multilineTextAlignment(.leading)
            }
            .navigationTitle(String(post.id ?? 0))
            .padding(.horizontal, 20)
    }
}

#Preview {
    PostDetailView(post: Posts(userId: 1, id: 1, title: "Title", body: "body"))
}
