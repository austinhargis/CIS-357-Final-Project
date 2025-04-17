//
//  FullscreenMapSheet.swift
//  muralmap
//
//  Created by Austin Hargis on 4/15/25.
//
import MapKit
import SwiftUI

enum MapStyleType: String, CaseIterable, Hashable {
    case standard, imagery, hybrid

    var mapStyle: MapStyle {
        switch self {
        case .standard: return .standard
        case .imagery: return .imagery
        case .hybrid: return .hybrid
        }
    }

    var displayName: String {
        switch self {
        case .standard: return "Standard"
        case .imagery: return "Imagery"
        case .hybrid: return "Hybrid"
        }
    }
}

struct FullscreenMapSheet: View {
    @Binding var showMapSheet: Bool
    @State private var mapStyle: MapStyleType = .standard
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            NearbyMap(mapStyle: mapStyle)
                .ignoresSafeArea()
            
            Picker("Map Style", selection: $mapStyle) {
                ForEach(MapStyleType.allCases, id: \.self) { style in
                    Text(style.displayName).tag(style)
                }
            }
            .pickerStyle(.segmented)
            .padding(4)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showMapSheet = false
                }) {
                    Image(systemName: "chevron.down")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var showMapSheet: Bool = true
    NavigationStack {
        FullscreenMapSheet(showMapSheet: $showMapSheet)
    }
}
