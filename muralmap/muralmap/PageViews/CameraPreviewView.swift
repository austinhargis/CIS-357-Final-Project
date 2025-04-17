//
//  CameraPreviewView.swift
//  muralmap
//
//  Created by Austin Hargis on 4/14/25.
//

import SwiftUI

struct CameraPreviewView: UIViewRepresentable {
    let cameraService: CameraService

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        if let previewLayer = cameraService.getPreviewLayer() {
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = cameraService.getPreviewLayer() {
            DispatchQueue.main.async {
                previewLayer.frame = uiView.bounds
            }
        }
    }
}
