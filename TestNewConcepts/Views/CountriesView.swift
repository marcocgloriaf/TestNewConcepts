//
//  CountriesView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 17/04/25.
//

import SwiftUI

struct CountriesView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: ViewModel
    @State private var searchCountry = ""
    private var countries: [Countries] = []
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(searchResults, id: \.self) { country in
                    let title = country.name ?? ""
                    NavigationLink {
                        CountryDetailView(country: country)
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
                viewModel.getCountries()
            }
        } detail: {
            Text("Select an item")
        }
        .searchable(text: $searchCountry) {
            ForEach(searchResults, id: \.self) { result in
                //Text("Are you looking for \(result)?").searchCompletion(result)
            }

            
        }
        
    }
    
    var searchResults: [Countries] {
        if searchCountry.isEmpty {
            return viewModel.countries
        }
        return viewModel.countries.filter {
            return $0.name!.contains(searchCountry)
        }
    }
}

#Preview {
    CountriesView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(ViewModel())
}
