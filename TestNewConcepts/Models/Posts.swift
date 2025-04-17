//
//  Posts.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 16/04/25.
//

struct Posts: Codable, Hashable {
    let userId: Int32?
    let id: Int32?
    let title: String?
    let body: String?
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PostArray: Codable {
    let posts: [Posts]
}

