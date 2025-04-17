//
//  ProfileView.swift
//  muralmap
//
//  Created by Austin Hargis on 2/8/25.
//

import SwiftUI

struct ProfileView: View {
    @State var showLoginSheet: Bool = false
    @State var isLoggedIn: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                // Profile Section
                Section {
                    HStack {
                        Image(systemName: "person.crop.circle.fill") // Placeholder profile image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                            
                        VStack(alignment: .leading) {
                            Text("John Doe") // Replace with actual name
                                .font(.headline)
                            Text("johndoe@example.com") // Example email
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
                    
                Section(header: Text("Content")) {
                    NavigationLink("Comments", destination: CommentsView())
                    NavigationLink("Favorites", destination: FavoritesView())
                    NavigationLink("Posts", destination: PostsView())
                }
                
                // Account Section
                Section(header: Text("Account")) {
                    NavigationLink("Profile", destination: PublicProfileView(targetUser: 32))
                    NavigationLink("Settings", destination: SettingsView())
                }
                
                // Log Out Section
                Section {
                    Button("Log Out") {
                        print("Logging out...")
                    }
                    .foregroundColor(.red)
                    .disabled(!isLoggedIn)
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            if !isLoggedIn {
                showLoginSheet = true
            }
        }
        .sheet(isPresented: $showLoginSheet, content: {
            NavigationStack {
                LoginSheet(showLoginSheet: $showLoginSheet)
            }
        })
    }
}

#Preview {
    ProfileView()
}
