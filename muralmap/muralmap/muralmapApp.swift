//
//  muralmapApp.swift
//  muralmap
//
//  Created by Austin Hargis on 2/7/25.
//

import SwiftUI

@main
struct muralmapApp: App {
    @State var settings = SettingsViewModel();
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
