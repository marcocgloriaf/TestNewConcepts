//
//  CommentDetailView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 17/04/25.
//

import SwiftUI

struct CommentDetailView: View {
    let comment: Comments
    var body: some View {
        let name = comment.name ?? ""
        let email = comment.email ?? ""
        let body = comment.body ?? ""
        LazyVStack(alignment: .leading) {
                
            Text("User ID: \(comment.postId ?? 0)")
                .multilineTextAlignment(.center)
            Spacer(minLength: 20)
            Text("Name:  \(name)")
                .multilineTextAlignment(.leading)
            Spacer(minLength: 20)
            Text("email: \(email)")
            Spacer(minLength: 20)
            Text("Body:  \(body)")
                .multilineTextAlignment(.leading)
            }
            .navigationTitle(String(comment.id ?? 0))
            .padding(.horizontal, 20)
    }
}

#Preview {
    CommentDetailView(comment: Comments(postId: 1, id: 1, name: "name", email: "email", body: "body"))
}
