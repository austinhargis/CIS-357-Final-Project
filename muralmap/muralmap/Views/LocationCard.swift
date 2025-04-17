//
//  LocationCard.swift
//  muralmap
//
//  Created by Austin Hargis on 2/25/25.
//

import SwiftUI

struct LocationCard: View {
    var location: Location
    @State private var uuid: UUID = UUID()
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Menu {
                    Button("Edit", action: { print("Edit tapped") })
                    Button("Delete", action: { print("Delete tapped") })
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                        .contentShape(Rectangle())
                }
                
            }
            .padding(8)
            
            AsyncImage(url: URL(string: location.locationImageName)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 420)
                    
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .clipped()
                        .transition(.opacity)
                        .id(uuid)
                    
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(maxWidth: 96, maxHeight: 96)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            uuid = UUID()
                        }
                    
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 420)

            
            HStack {
                Image(systemName: "heart")
                    .imageScale(.medium)
                
                Spacer()
                
                Image(systemName: "bookmark")
                    .imageScale(.medium)
                
            }
            .padding(.horizontal, 4)
            
            HStack {
                Text(location.locationTitle)
                    .font(.title)
                
                Spacer()
            }
            .padding(.horizontal, 4)
            
            HStack {
                Text(location.locationDescription ?? "")
                    .font(.callout)
                Spacer()
            }
            .padding(.horizontal, 4)
        
            Spacer()
            
        }
        .shadow(color: .black, radius: 1)
    }
}

#Preview {
    LocationCard(location: Location(locationId: 1, userId: 1, longitude: 40, latitude: -80, locationTitle: "Test Title", locationDescription: "Test Description", locationImageName: "https://mural-map.org/locationImages/IMG_5655.jpeg", isFeatured: false))
}
