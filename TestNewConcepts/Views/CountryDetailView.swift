//
//  CountryDetailView.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 17/04/25.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Countries
    var body: some View {
        let name = country.name ?? ""
        let capital = country.capital ?? ""
        let code = country.code ?? ""
        let region = country.region ?? ""

        LazyVStack(alignment: .leading) {
                
            Text("Country name: \(name)")
                .multilineTextAlignment(.center)
            Spacer(minLength: 20)
            Text("Capital:  \(capital)")
                .multilineTextAlignment(.leading)
            Spacer(minLength: 20)
            Text("Country code: \(code)")
            Spacer(minLength: 20)
            Text("Region:  \(region)")
                .multilineTextAlignment(.leading)
            }
            .navigationTitle(String(country.name ?? ""))
            .padding(.horizontal, 20)
    }
}

#Preview {
    CountryDetailView(country: Countries(name: "Mexico", region: "America", code: "MX", capital: "Ciudad de Mexico"))
}
