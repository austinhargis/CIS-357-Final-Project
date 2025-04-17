//
//  CameraManager.swift
//  muralmap
//
//  Created by Austin Hargis on 4/12/25.
//
//  Camera implementation (largely) from: https://www.createwithswift.com/camera-capture-setup-in-a-swiftui-app/
//      I couldn't get a fair chunk of this working the way I wanted, so it's cobbled toogether from several tutorial videos, articles, and StackOverflow posts

import AVFoundation
import Foundation
import UIKit

class CameraManager: NSObject {
    private let captureSession = AVCaptureSession()
    private var deviceInput: AVCaptureDevice?
    private var videoOutput: AVCaptureVideoDataOutput?
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    
    private var addToPreviewStream: ((CGImage) -> Void)?
    
    override init() {
        super.init()
        
        Task {
            await configureSession()
//            await startSession()
        }
    }
    
    private func configureSession() async {
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera)
        else { return }
        
    
        captureSession.beginConfiguration()
        
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
    
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        
        guard captureSession.canAddInput(deviceInput) else {
            print("Unable to add device input to capture session.")
            return
        }
        
     
        guard captureSession.canAddOutput(videoOutput) else {
            print("Unable to add video output to capture session.")
            return
        }
        
       
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
    }
    
    
    func startSession() async {
        guard await isAuthorized else { return }
               
        captureSession.startRunning()
    }

    func stopSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    private var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
    
}
