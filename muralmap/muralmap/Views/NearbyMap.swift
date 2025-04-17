//
//  NearbyMap.swift
//  muralmap
//
//  Created by Austin Hargis on 4/15/25.
//
import MapKit
import SwiftUI

struct NearbyMap: View {
    @State var locationManager: LocationManager = LocationManager();
    @State var position: MapCameraPosition = .automatic
    @State var nearbyLocations: [Location] = []
    var mapStyle: MapStyleType? = .standard
    
    var body: some View {
        VStack {
            Map(position: $position) {
                if let userLocation = locationManager.manager.location?.coordinate {
                    Marker("Your Location", coordinate: userLocation)
                }
                
                if !nearbyLocations.isEmpty {
                    ForEach(nearbyLocations) { location in
                        Annotation(location.locationTitle,
                                   coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                            VStack {
                                NavigationLink(destination: LocationView(locationId: location.locationId)) {
                                    
                                    AsyncImage(url: URL(string: location.locationImageName)) {
                                        phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                        } else {
                                            ProgressView()
                                        }
                                            
                                    }
                                    .frame(width: 48, height: 48)
                                    .padding(2)
                                    .background(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 1)
                                }
                            }
                        }
                    }
                }
                
            }
            .mapStyle(mapStyle?.mapStyle ?? .standard)
        }
        .onAppear{
            let newLocation = locationManager.manager.location?.coordinate ?? CLLocationCoordinate2D()
            position = MapCameraPosition.region(MKCoordinateRegion(center: newLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
            
        }
        .task  {
            await fetchNearbyLocations()
        }
    }
    
    // TODO: Consolidate this later with the search
    func fetchNearbyLocations() async {
        guard let url = URL(string: "https://\(Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") ?? "")/api/location/nearby?latitude=\(self.locationManager.manager.location?.coordinate.latitude ?? 0)&longitude=\(self.locationManager.manager.location?.coordinate.longitude ?? 0)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.nearbyLocations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            print(error)
        }
    }
}

#Preview {
    NearbyMap()
}
