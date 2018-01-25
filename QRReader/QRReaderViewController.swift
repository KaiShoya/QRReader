//
//  ViewController.swift
//  QRReader
//
//  Created by 甲斐翔也 on 2018/01/25.
//  Copyright © 2018 Kai Shoya. All rights reserved.
//

import UIKit

class QRReaderViewController: UIViewController, CameraViewControllerDelegate {
    let cameraView = CameraViewController()
    
    private var label: UILabel!
    private var showCameraBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタン設定
        showCameraBtn = UIButton()
        showCameraBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        showCameraBtn.backgroundColor = UIColor.clear
        showCameraBtn.layer.masksToBounds = true
        
        showCameraBtn.setTitle("カメラ起動", for: UIControlState.normal)
        showCameraBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        showCameraBtn.layer.cornerRadius = 10.0
        showCameraBtn.layer.position = CGPoint(x: 70, y: 70)
        showCameraBtn.addTarget(self, action: #selector(self.showCamera(sender:)), for: .touchDown)
        
        self.view.addSubview(showCameraBtn)

        // ラベル設定
        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 50
        let labelPosX: CGFloat = self.view.bounds.width/2 - labelWidth/2
        let labelPosY: CGFloat = self.view.bounds.height/2 - labelHeight/2
        
        label = UILabel(frame: CGRect(x: labelPosX, y: labelPosY, width: labelWidth, height: labelHeight))
        
        self.view.addSubview(label)
        
        self.cameraView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc internal func showCamera(sender: UIButton) {
        self.present(self.cameraView, animated: true, completion: nil)
    }
    
    func modalDidFinished(modalText: String) {
        label.text = modalText
        self.cameraView.dismiss(animated: true, completion: nil)
    }
}

