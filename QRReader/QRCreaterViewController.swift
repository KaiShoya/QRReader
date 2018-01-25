//
//  CreateQR.swift
//  QRReader
//
//  Created by 甲斐翔也 on 2018/01/25.
//  Copyright © 2018 Kai Shoya. All rights reserved.
//

import UIKit
class QRCreaterViewController: UIViewController {
    private var qrCreateBtn: UIButton!
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタン設定
        qrCreateBtn = UIButton()
        qrCreateBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        qrCreateBtn.backgroundColor = UIColor.clear
        qrCreateBtn.layer.masksToBounds = true
        
        qrCreateBtn.setTitle("QRコード作成", for: UIControlState.normal)
        qrCreateBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        qrCreateBtn.layer.cornerRadius = 10.0
        qrCreateBtn.layer.position = CGPoint(x: 70, y: 70)
        qrCreateBtn.addTarget(self, action: #selector(self.qrQreate(sender:)), for: .touchDown)
        
        self.view.addSubview(qrCreateBtn)
        
        // imageview設定
        let imageViewWidth: CGFloat = 300
        let imageViewHeight: CGFloat = 300
        let imageViewPosX: CGFloat = (self.view.bounds.width - imageViewWidth)/2
        let imageViewPosY: CGFloat = (self.view.bounds.height - imageViewHeight)/2
        imageView = UIImageView(frame: CGRect(x: imageViewPosX, y: imageViewPosY, width: imageViewWidth, height: imageViewHeight))
        imageView.image = nil
        
        self.view.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc internal func qrQreate(sender: UIButton) {
        let str = "abcdefg"
        
        let data = str.data(using: String.Encoding.utf8)!
        let qr = CIFilter(name: "CIQRCodeGenerator", withInputParameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let ciImage = qr.outputImage!.transformed(by: sizeTransform)
        
        imageView.image = UIImage.init(ciImage: ciImage)
    }
}
