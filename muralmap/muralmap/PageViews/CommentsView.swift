//
//  CommentsView.swift
//  muralmap
//
//  Created by Austin Hargis on 3/25/25.
//

import SwiftUI

struct CommentsView: View {
    // TODO: Change type later
    @State private var userComments: [Location] = []
    @State private var editingComments: Bool = false
    var body: some View {
        VStack {
            if userComments.isEmpty {
                HStack {
                    Text("You have no comments yet!")
                    Spacer()
                }
                .padding()
                Spacer()
            } else {
                List(userComments) {
                    comment in
                    NavigationLink(destination: LocationView(locationId: comment.locationId)) {
                        AsyncImage(url: URL(string: comment.locationImageName)) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                            }
                        
                        Text(comment.locationTitle)
                            .font(.headline)
                        
                    }
                    .frame(maxHeight: 50)
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editingComments ? "Cancel" : "Edit") {
                    editingComments = !editingComments
                }
                .disabled(userComments.isEmpty)
            }
        }
        .navigationTitle("Your Comments")
        
    }
}

#Preview {
    return NavigationStack {
        CommentsView()
    }
}
