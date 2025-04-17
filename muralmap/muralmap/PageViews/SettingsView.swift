//
//  SettingsView.swift
//  muralmap
//
//  Created by Austin Hargis on 3/25/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Section(header: Text("General").font(.title)) {
                    Toggle("Dark Mode", isOn: $settings.darkModeEnabled)
                    Toggle("Allow Comments on Posts", isOn: $settings.allowCommentsOnPosts)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Section(header: Text("Push Notifications").font(.title)) {
                    Toggle("Comments", isOn: $settings.commentPushNotifs)
                    Toggle("Likes", isOn: $settings.likesPushNotifs)
                    Toggle("Post Approval", isOn: $settings.postApprovedPushNotifs)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .navigationTitle("Settings")
            .padding()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
