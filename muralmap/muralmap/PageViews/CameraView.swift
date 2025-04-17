//
//  CameraPreviewView.swift
//  muralmap
//
//  Created by Austin Hargis on 4/9/25.
//

import AVFoundation
import SwiftUI
import UIKit

import SwiftUI

struct CameraView: View {
    @StateObject private var cameraService = CameraService()
    @Environment(\.dismiss) private var dismiss
    @Binding var capturedImage: UIImage?


    var body: some View {
        VStack {
            CameraPreviewView(cameraService: cameraService)
                .ignoresSafeArea()

            Button(action: {
                cameraService.capturePhoto()
            }) {
                Text("Capture")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onReceive(cameraService.$capturedImage) { newImage in
            if let image = newImage {
                capturedImage = image
                dismiss()
            }
        }
        .onAppear {
            cameraService.start()
        }
        .onDisappear {
            cameraService.stop()
        }
    }
}

//#Preview {
//    CameraView()
//}
