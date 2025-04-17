//
//  SearchView.swift
//  muralmap
//
//  Created by Austin Hargis on 2/16/25.
//

import SwiftUI

struct SearchView: View {
    @State var locationManager: LocationManager = LocationManager();
    @State var nearbyLocations: [Location] = []
    @State private var searchText: String = ""
    @State var searchResults: [Location] = []
    
    var body: some View {
        VStack {
            List {
                if searchText.isEmpty {
                    ForEach(nearbyLocations) {
                        location in NavigationLink(destination: LocationView(locationId: location.locationId)) {
                            Text(location.locationTitle)
                        }
                    }
                } else {
                    ForEach(searchResults) {
                        location in NavigationLink(destination: LocationView(locationId: location.locationId)) {
                            Text(location.locationTitle)
                        }
                    }
                }
            }
        }
        .navigationTitle("Search Nearby")
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            Task {
                await fetchNearbyLocations()
            }
        }
        .onChange(of: searchText) {
            fetchSearchResults()
        }
    }
    
    func fetchSearchResults() {
        searchResults = nearbyLocations.filter {
            location in
            location.locationTitle.lowercased().contains(searchText.lowercased())
        }
    }

    func fetchNearbyLocations() async {
        guard let url = URL(string: "https://\(Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") ?? "")/api/location/nearby?latitude=\(self.locationManager.manager.location?.coordinate.latitude ?? 0)&longitude=\(self.locationManager.manager.location?.coordinate.longitude ?? 0)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.nearbyLocations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            print(error)
        }
    }
    
}

#Preview {
    SearchView()
}
