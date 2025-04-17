//
//  PublicProfileView.swift
//  muralmap
//
//  Created by Austin Hargis on 3/25/25.
//

import SwiftUI

struct PublicProfileView: View {
    var targetUser: Int
    
    var body: some View {
        Text("Hello, \(targetUser)!")
    }
}

#Preview {
    PublicProfileView(targetUser: 32)
}
