//
//  CameraViewController.swift
//  QRReader
//
//  Created by 甲斐翔也 on 2018/01/25.
//  Copyright © 2018 Kai Shoya. All rights reserved.
//

import UIKit
import AVFoundation

protocol CameraViewControllerDelegate {
    func modalDidFinished(modalText: String)
}

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var delegate: CameraViewControllerDelegate! = nil
    private let session = AVCaptureSession()
    
    private var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video, position: .back)
        let devices = discoverySession.devices
        
        if let backCamera = devices.first {
            do {
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)
                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)
                    
                    let metadataOutput = AVCaptureMetadataOutput()
                    
                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)
                        
                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr]
                        
                        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                        previewLayer.frame = self.view.bounds
                        previewLayer.videoGravity = .resizeAspectFill
                        self.view.layer.addSublayer(previewLayer)
                        
                        self.session.startRunning()
                    }
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
        
        backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        backBtn.backgroundColor = UIColor.clear
        backBtn.layer.masksToBounds = true
        
        backBtn.setTitle("< 戻る", for: UIControlState.normal)
        backBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        backBtn.layer.cornerRadius = 10.0
        backBtn.layer.position = CGPoint(x: 50, y: 50)
        backBtn.addTarget(self, action: #selector(self.back(sender:)), for: .touchDown)
        
        self.view.addSubview(backBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            if metadata.type != .qr { continue }
            if metadata.stringValue == nil { continue }
            
            self.delegate.modalDidFinished(modalText: metadata.stringValue!)
        }
    }
    
    @objc internal func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
