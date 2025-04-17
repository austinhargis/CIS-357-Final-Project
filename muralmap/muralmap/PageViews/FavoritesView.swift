//
//  FavoritesView.swift
//  muralmap
//
//  Created by Austin Hargis on 3/25/25.
//

import SwiftUI

struct FavoritesView: View {
    @State private var userFavorites: [Location] = []
    @State private var editingFavorites: Bool = false
    var body: some View {
        VStack {
            if userFavorites.isEmpty {
                HStack {
                    Text("You have no favorites yet!")
                    Spacer()
                }
                .padding()
                Spacer()
            } else {
                List(userFavorites) {
                    favorite in
                    NavigationLink(destination: LocationView(locationId: favorite.locationId)) {
                        AsyncImage(url: URL(string: favorite.locationImageName)) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                            }
                        
                        Text(favorite.locationTitle)
                            .font(.headline)
                        
                        
                        
                    }
                    .frame(maxHeight: 50)
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editingFavorites ? "Cancel" : "Edit") {
                    editingFavorites = !editingFavorites
                }
                .disabled(userFavorites.isEmpty)
            }
        }
        .navigationTitle("Your Favorites")
        
    }
}

#Preview {
    return NavigationStack {
        FavoritesView()
    }
}
