//
//  LocationManager.swift
//  muralmap
//
//  Created by Austin Hargis on 2/7/25.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var manager = CLLocationManager()
    
    func checkLocationAuthorizationStatus() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                print("Restricted or denied")
        case .authorizedAlways:
            print("Authorized always")
        case .authorizedWhenInUse:
            print("Authorized when in use")
        @unknown default:
            print("Disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
}
