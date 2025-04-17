//
//  Countries.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 16/04/25.
//

struct Countries: Codable, Hashable {
    //let id: Int
    let name: String?
    let region: String?
    let code: String?
    let capital: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}

struct CountriesArray: Codable {
    let comments: [Countries]
}
