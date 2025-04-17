//
//  HomeView.swift
//  muralmap
//
//  Created by Austin Hargis on 2/7/25.
//

import MapKit
import SwiftUI

struct HomeView: View {
    @State var showMapSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    NearbyMap()
                        .cornerRadius(15)
                        .frame(height: 240)
                        .onTapGesture {
                            showMapSheet = true
                        }
                    
                    Text("Welcome to Trove!")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Trove is a free app that allows you to explore local art, architecture, and other cool stuff in your area.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .padding(8)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
        .sheet(isPresented: $showMapSheet, content: {
            NavigationStack {
                FullscreenMapSheet(showMapSheet: $showMapSheet)
            }
        })
        
    }
}

#Preview {
    return NavigationStack {
        HomeView()
    }
}
