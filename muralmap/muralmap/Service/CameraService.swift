//
//  CameraService.swift
//  muralmap
//
//  Created by Austin Hargis on 4/14/25.
//

import AVFoundation
import SwiftUI

class CameraService: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    private var session: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    @Published var isRunning = false
    @Published var capturedImage: UIImage?

    override init() {
        super.init()
        setup()
    }

    func setup() {
        session = AVCaptureSession()
        session?.sessionPreset = .high

        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              (session?.canAddInput(videoDeviceInput) ?? false) else {
            return
        }

        session?.addInput(videoDeviceInput)

        let output = AVCapturePhotoOutput()
        if session?.canAddOutput(output) == true {
            session?.addOutput(output)
            self.photoOutput = output
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
    }

    func start() {
        session?.startRunning()
        isRunning = true
    }

    func stop() {
        session?.stopRunning()
        isRunning = false
    }

    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return videoPreviewLayer
    }
    
    func capturePhoto() {
            let settings = AVCapturePhotoSettings()
            if photoOutput?.availablePhotoCodecTypes.contains(.jpeg) == true {
                settings.photoQualityPrioritization = .balanced
            }
            
            photoOutput?.capturePhoto(with: settings, delegate: self)
        }
        
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }
        
        if let imageData = photo.fileDataRepresentation(),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.capturedImage = image
            }
        }
    }
}
