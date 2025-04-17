//
//  LocationView.swift
//  muralmap
//
//  Created by Austin Hargis on 2/8/25.
//

import MapKit
import SwiftUI

struct LocationView: View {
    @State var locationId: Int;
    @State private var expandedLocation: LocationSingleResponse? = nil;
    @State private var position: MapCameraPosition = .automatic;
    
    var body: some View {
        
        ScrollView(.vertical) {
            GeometryReader { geometry in
                AsyncImage(url: URL(string: self.expandedLocation?.location.locationImageName ?? "")) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                .frame(width: geometry.size.width, height: 400)
                .clipped()
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
            .frame(height: 400)
            
            VStack {
                Text(self.expandedLocation?.location.locationTitle ?? "")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                HStack {
                    if expandedLocation?.rating?.ratingCount ?? 0 > 0 {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color(.red))
                            .frame(alignment: .leading)

                        Text("\((expandedLocation?.rating?.rating ?? 0) / 2) / 5 (\(expandedLocation?.rating?.ratingCount ?? 0))")
                    } else {
                        Text("No ratings")
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 4)
                
                
                Text(self.expandedLocation?.location.locationDescription ?? "")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
            
            HStack {
                // TODO: Update blip to use custom image
                Map(position: $position) {
                    Marker(self.expandedLocation?.location.locationTitle ?? "", coordinate: CLLocationCoordinate2D(latitude: self.expandedLocation?.location.latitude ?? 0, longitude: self.expandedLocation?.location.longitude ?? 0))
                }
                .mapStyle(.imagery())
            }
            .frame(height: 250)
            .cornerRadius(10)
            .padding(8)
            .onTapGesture {
                if let latitude = self.expandedLocation?.location.latitude,
                   let longitude = self.expandedLocation?.location.longitude {
                    
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let placemark = MKPlacemark(coordinate: coordinate)
                    let mapItem = MKMapItem(placemark: placemark)
                    
                    mapItem.name = self.expandedLocation?.location.locationTitle
                    
                    mapItem.openInMaps(launchOptions: [
                        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
                    ])
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await retrieveLocationExpanded()
        }
    }
    
    func retrieveLocationExpanded() async {
        guard let url = URL(string: "https://\(Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") ?? "")/api/location/\(locationId)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.expandedLocation = try JSONDecoder().decode(LocationSingleResponse.self, from: data)
        } catch {
            print(error)
        }
        
        position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.expandedLocation?.location.latitude ?? 0, longitude: self.expandedLocation?.location.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
    }
}

#Preview {
    LocationView(locationId: 1)
}
