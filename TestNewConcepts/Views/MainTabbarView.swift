//
//  MainTabbarView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 17/04/25.
//

import SwiftUI

struct MainTabbarView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: ViewModel
    var body: some View {
        TabView {
            ContentView()
                .modelContainer(for: Item.self, inMemory: true)
                .environmentObject(viewModel)
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            CommentsView()
                .modelContainer(for: Item.self, inMemory: true)
                .environmentObject(viewModel)
                .tabItem {
                    Label("Comments", systemImage: "square.and.pencil")
                }
            CountriesView()
                .modelContainer(for: Item.self, inMemory: true)
                .environmentObject(viewModel)
                .tabItem {
                    Label("Countries", systemImage: "map")
                }

        }
    }
}

#Preview {
    MainTabbarView()
}
