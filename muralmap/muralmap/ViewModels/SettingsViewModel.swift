//
//  SettingsViewModel.swift
//  muralmap
//
//  Created by Austin Hargis on 4/3/25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var darkModeEnabled: Bool = true
    @Published var allowCommentsOnPosts: Bool = true
    
    @Published var commentPushNotifs: Bool = false
    @Published var likesPushNotifs: Bool = false
    @Published var postApprovedPushNotifs: Bool = false
}
