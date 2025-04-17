//
//  PostsView.swift
//  muralmap
//
//  Created by Austin Hargis on 3/25/25.
//

import SwiftUI

struct PostsView: View {
    @State var userPosts: [Location] = []
    @State var editingPosts: Bool = false
    var body: some View {
        VStack {
            if userPosts.isEmpty {
                HStack {
                    Text("You have no posts yet!")
                    Spacer()
                }
                .padding()
                Spacer()
            } else {
                List(userPosts) {
                    post in
                    NavigationLink(destination: LocationView(locationId: post.locationId)) {
                        AsyncImage(url: URL(string: post.locationImageName)) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                            }
                        
                        Text(post.locationTitle)
                            .font(.headline)
                        
                        
                        
                    }
                    .frame(maxHeight: 50)
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editingPosts ? "Cancel" : "Edit") {
                    editingPosts = !editingPosts
                }
                .disabled(userPosts.isEmpty)
            }
        }
        .navigationTitle("Your Posts")
        
    }
}

#Preview {
    var sampleData: [Location] = []
    let loc1 = Location(locationId: 1, userId: 1, longitude: 15, latitude: 15, locationTitle: "Test Location", locationDescription: "Test Description", locationImageName: "https://mural-map.org/locationImages/IMG_5655.jpeg", isFeatured: false)
    sampleData.append(loc1)
    
    return NavigationStack {
        PostsView(userPosts: sampleData)
    }
}
