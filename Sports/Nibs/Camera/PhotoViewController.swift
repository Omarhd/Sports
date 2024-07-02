//
//  CameraViewController.swift
//  Sports
//
//  Created by ios Dev on 01/07/2024.
//

import UIKit
import AVFoundation

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var flipCameraButton: UIButton!
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var capturePhotoOutput: AVCapturePhotoOutput!
    var currentCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var isUsingFrontCamera = false
    var flashMode: AVCaptureDevice.FlashMode = .off

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameras()
        setupCamera()
    }

    func setupCameras() {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == .back {
                backCamera = device
            } else if device.position == .front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        configureSession()
    }

    func configureSession() {
        
        guard let camera = currentCamera else {
            print("Unable to access camera!")
            return
        }

        do {
            captureSession.beginConfiguration()
            
            if let currentInputs = captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in currentInputs {
                    captureSession.removeInput(input)
                }
            }

            let input = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            captureSession.outputs.forEach { output in
                captureSession.removeOutput(output)
            }

            capturePhotoOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(capturePhotoOutput) {
                captureSession.addOutput(capturePhotoOutput)
            }

            captureSession.commitConfiguration()

            setupPreviewLayer()
        } catch {
            print("Error Unable to initialize camera: \(error.localizedDescription)")
            captureSession.commitConfiguration()
        }
    }

    func setupPreviewLayer() {
        videoPreviewLayer?.removeFromSuperlayer()
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer.frame = previewView.bounds
        previewView.layer.addSublayer(videoPreviewLayer)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
            DispatchQueue.main.async {
                self?.videoPreviewLayer.frame = self?.previewView.bounds ?? .zero
            }
        }
    }

    @IBAction func captureButtonTapped(_ sender: UIButton) {
        print("Capture button tapped")
        capturePhoto()
    }

    func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = flashMode // Set the flash mode here
        print("Capturing photo...")
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }

    @IBAction func flipCameraAction(_ sender: Any) {
        isUsingFrontCamera.toggle()
        currentCamera = isUsingFrontCamera ? frontCamera : backCamera
        configureSession()
    }

    @IBAction func flashAction(_ sender: Any) {
        switch flashMode {
        case .off:
            flashMode = .on
            flashButton.setImage(UIImage(systemName: "bolt.fill"), for: .normal)
        case .on:
            flashMode = .off
            flashButton.setImage(UIImage(systemName: "bolt.slash.fill"), for: .normal)
        default:
            break
        }
    }
}

extension PhotoViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }

        guard let imageData = photo.fileDataRepresentation() else {
            print("No image data found")
            return
        }

        let image = UIImage(data: imageData)
        print("Photo captured: \(image?.size ?? CGSize.zero)")

        // Verify that the capture session is still running
        if captureSession.isRunning {
            print("Capture session is still running")
            captureSession.stopRunning()
        } else {
            print("Capture session has stopped")
        }
    }
}
