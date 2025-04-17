//
//  BrowseView.swift
//  muralmap
//
//  Created by Austin Hargis on 2/8/25.
//

import SwiftUI

struct BrowseView: View {
    @State var locations: [Location] = []
    @State private var listIndx = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action:{
                        listIndx -= 1
                    }) {
                        Image(systemName: "chevron.left")
                        Text("Page \(listIndx > 0 ? listIndx + 1 : 1)")
                    }
                    .disabled(listIndx <= 0)
                    
                    Spacer()
                    
                    Button(action: {
                        listIndx += 1
                    }) {
                        Text("Page \(listIndx + 2)")
                        Image(systemName: "chevron.right")
                    }
                    .disabled(locations.count / 4 < listIndx + 1)
                }
                .padding()
                
                ScrollView(.vertical) {
                    if locations.isEmpty {
                        HStack {
                            Text("We couldn't find any locations!")
                            Spacer()
                        }
                    } else {
                        LazyVStack {
                            ForEach(locations[pageStartIndex()...pageEndIndex()]) { location in
                                LocationCard(location: location)
                            }
                        }
                    }
                    
                    
                    
                }
                .navigationTitle("Browse Locations")
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await fetchAllLocations();
        }
    }

    func pageStartIndex() -> Int {
        return listIndx + (4 * listIndx)
    }
    
    func pageEndIndex() -> Int {
        return listIndx + 4
    }
    
    func fetchAllLocations() async {
        guard let url = URL(string: "https://\(Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") ?? "")/api/location/") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.locations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
//            print(error)
        }
    }
}

#Preview {
    BrowseView()
}
