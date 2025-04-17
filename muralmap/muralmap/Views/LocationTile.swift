//
//  LocationTile.swift
//  muralmap
//
//  Created by Austin Hargis on 2/7/25.
//

import SwiftUI

struct LocationTile: View {
    var location: Location
    
    var body: some View {
        
        ZStack {
            
            AsyncImage(url: URL(string: location.locationImageName)) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                .frame(maxWidth: 200, maxHeight: 200)
            
            
            VStack {
                
                if location.isFeatured {
                    HStack {
                        Text("Featured")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                    }
                    .background(Color.yellow.opacity(0.75))
                }
                
                Spacer()
                
                HStack {
                    Text(location.locationTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                }
                .background(Color.blue.opacity(0.75))
            }
        }
        .cornerRadius(14)
        .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 200)
        .shadow(color: .black, radius: 1)
    }
}

#Preview {
    LocationTile(location: Location(locationId: 1, userId: 1, longitude: 40, latitude: -80, locationTitle: "Test Title", locationDescription: "Test Description", locationImageName: "https://mural-map.org/locationImages/1738943090325-af6e38", isFeatured: false))
}
