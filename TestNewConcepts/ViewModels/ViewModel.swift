//
//  ViewModel.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 16/04/25.
//

import Combine

class ViewModel: ObservableObject {
    @Published var postsArray: [Posts] = []
    @Published var netManagerError: Error?
    @Published var countries: [Countries] = []
    @Published var comments: [Comments] = []
    private var cancellable: AnyCancellable?
    

    
    init() {}

    func getPosts() {
        Task {
            let info = await NetworkManager.shared.fetchPosts()
            let posts = info.0
            let error = info.1
            if let posts = posts {
                // do table reload
                await MainActor.run {
                    self.postsArray = posts
                }
            }
            if let error = error {
                // do error part
                self.netManagerError = error
            }
        }
    }

    func getCountries() {
        Task {
            let info = await NetworkManager.shared.fetchData()
            let countries = info.0
            let error = info.1
            if let countries = countries {
                // do table reload
                self.countries = countries
            }
            if let error = error {
                // do error part
                self.netManagerError = error
            }
        }
    }
}
