//
//  Location.swift
//  muralmap
//
//  Created by Austin Hargis on 2/7/25.
//

import Foundation

struct Location: Codable, Identifiable, Hashable {
    var id: Int { locationId }
    
    let locationId: Int
    let userId: Int?
    let longitude: Double
    let latitude: Double
    let locationTitle: String
    let locationDescription: String?
    let locationImageName: String
    let isFeatured: Bool
}
