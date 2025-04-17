//
//  HorizontalLocationTileScroller.swift
//  muralmap
//
//  Created by Austin Hargis on 2/14/25.
//

import SwiftUI

struct HorizontalLocationTileScroller: View {
    var heading: String
    var locations: [Location]
    
    var body: some View {
        Text(heading).font(.title).frame(maxWidth: .infinity, alignment: .leading).padding(8)
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                ForEach(locations) {
                    location in NavigationLink(destination: LocationView(locationId: location.locationId)) {
                        LocationTile(location: location)
                    }
                }
            }
        }
        .frame(height: 250)
        .contentMargins(8)
    }
}

#Preview {
    HorizontalLocationTileScroller(heading: "Test Heading", locations: [])
}
