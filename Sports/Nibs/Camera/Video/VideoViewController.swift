//
//  VideoViewController.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var flipCameraButton: UIButton!
    @IBOutlet weak var videoPlayerView: UIView! // Add this IBOutlet for displaying the recorded video
    @IBOutlet weak var discardButton: UIButton! // Add this IBOutlet for discarding the recorded video
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var movieOutput: AVCaptureMovieFileOutput!
    var currentCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var isUsingFrontCamera = false
    var isRecording = false
    var timer: Timer?
    var startTime: Date?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var recordedURL: URL? // Store the recorded video URL

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
            
            // Remove existing inputs
            if let currentInputs = captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in currentInputs {
                    captureSession.removeInput(input)
                }
            }

            let input = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            // Remove existing outputs
            captureSession.outputs.forEach { output in
                captureSession.removeOutput(output)
            }

            movieOutput = AVCaptureMovieFileOutput()
            if captureSession.canAddOutput(movieOutput) {
                captureSession.addOutput(movieOutput)
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

    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    func startRecording() {
        if !movieOutput.isRecording {
            let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
            isRecording = true
            recordButton.setTitle("Stop", for: .normal)
            startTime = Date()
            startTimer()
            flipCameraButton.isHidden = true

        }
    }

    func stopRecording() {
        if movieOutput.isRecording {
            movieOutput.stopRecording()
            isRecording = false
            recordButton.setTitle("Record", for: .normal)
            timer?.invalidate()
            startTime = nil
            flipCameraButton.isHidden = false
            // Store the recorded video URL
            recordedURL = movieOutput.outputFileURL
            
            // Display recorded video
            displayRecordedVideo()
        }
    }

    @IBAction func flipCameraAction(_ sender: Any) {
        isUsingFrontCamera.toggle()
        currentCamera = isUsingFrontCamera ? frontCamera : backCamera

        configureSession()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        guard let startTime = startTime else { return }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        
        let milliseconds = Int(elapsedTime * 100) % 100
        let seconds = Int(elapsedTime) % 60
        let minutes = Int(elapsedTime / 60)
        
        let timeString = String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
        recordButton.setTitle(timeString, for: .normal)
        
        if elapsedTime >= 15 {
            stopRecording()
        }
    }

    func displayRecordedVideo() {
        guard let recordedURL = recordedURL else {
            print("No recorded video URL found.")
            return
        }
        
        player = AVPlayer(url: recordedURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.frame = videoPlayerView.bounds
        
        videoPlayerView.layer.addSublayer(playerLayer!)
        videoPlayerView.isHidden = false
        
        player?.play()
        
        discardButton.isHidden = false
    }

    @IBAction func discardButtonTapped(_ sender: UIButton) {
        // Remove the displayed video
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        videoPlayerView.isHidden = true
        
        deleteRecordedVideo()
        
        discardButton.isHidden = true
    }

    func deleteRecordedVideo() {
        guard let recordedURL = recordedURL else { return }
        
        do {
            try FileManager.default.removeItem(at: recordedURL)
            print("Recorded video deleted successfully.")
        } catch {
            print("Error deleting recorded video: \(error.localizedDescription)")
        }
        
        // Reset recordedURL
        self.recordedURL = nil
    }
}

extension VideoViewController: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
            return
        }

        // Do something with the video file (e.g., save to photo library, upload, etc.)
        print("Video recorded to: \(outputFileURL.absoluteString)")
    }
}
