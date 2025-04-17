//
//  Comments.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 16/04/25.
//


struct Comments: Codable, Hashable {
    let postId: Int32?
    let id: Int32?
    let name: String?
    let email: String?
    let body: String?
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CommentsArray: Codable {
    let comments: [Comments]
}
