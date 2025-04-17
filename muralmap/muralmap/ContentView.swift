//
//  ContentView.swift
//  muralmap
//
//  Created by Austin Hargis on 2/7/25.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        TabView {
            VStack {
                HomeView();
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            
            VStack {
                BrowseView();
            }
            .tabItem{
                Image(systemName: "square.grid.2x2")
                Text("Browse")
            }.tag(1)
            
            // REMOVED FOR DEMO PURPOSES / ENDPOINTS INCOMPLETE
//            VStack {
//                CreatePostView()
//            }
//            .tabItem{
//                Image(systemName: "plus.square")
//                Text("Create Post")
//            }.tag(2)
            
            VStack {
                ProfileView()
            }
            .tabItem{
                Image(systemName: "person.crop.circle")
                Text("Profile")
            }
            .tag(3)
        }
        .onAppear {
            locationManager.checkLocationAuthorizationStatus()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SettingsViewModel())
}
