//
//  LocationSingleResponse.swift
//  muralmap
//
//  Created by Austin Hargis on 2/8/25.
//

import Foundation

struct LocationSingleResponse: Codable, Identifiable {
    var id: Int { location.locationId }
    
    let location: Location
    let rating: LocationRating?
}
