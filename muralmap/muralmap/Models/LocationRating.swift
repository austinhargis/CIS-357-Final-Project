//
//  LocationRating.swift
//  muralmap
//
//  Created by Austin Hargis on 2/8/25.
//

import Foundation

struct LocationRating: Codable, Identifiable {
    var id: Int { locationId ?? 0 }
    
    let userId: Int?;
    let locationId: Int?
    let rating: Int?
    let ratingCount: Int?
}
