//
//  AuthenticationViewController+Extension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 29/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Photos
import UIKit
import Vision
import AVFoundation
import VideoToolbox

extension AuthenticationViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is contains at least one object.
        
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            imagePatternFrameView?.frame = CGRect.zero
            //messageLabel.isHidden = true
            return
        }
        
        if self.isPhotoCaptured {
            return
        }
        
        // Get the metadata object.
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            //self.onTapTakePhoto(self);
            //self.captureSession?.stopRunning()
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            if let barCodeFrame = barCodeObject?.bounds {
                qrCodeFrameView?.frame =  CGRect.init(x: barCodeFrame.origin.x , y: barCodeFrame.origin.y, width: barCodeFrame.size.width, height: barCodeFrame.size.height)
                
                let width1 = (barCodeFrame.size.width)*1.30
                let height1 = (barCodeFrame.size.height)*1.30
                let xCoordinate1 = barCodeFrame.origin.x - (barCodeFrame.size.width * 0.103)//(x)*0.97
                let yCoordinate1 = (barCodeFrame.origin.y) + barCodeFrame.size.height + (barCodeFrame.size.height * 0.051)
                let croppingRect1 = CGRect(x: xCoordinate1, y: yCoordinate1, width: width1, height: height1)
                imagePatternFrameView?.frame = croppingRect1
            }
            
            if metadataObj.stringValue != nil {
                // messageLabel.isHidden = false
                //messageLabel.text
                qrcodeData = metadataObj.stringValue
            }
            //DispatchQueue.delay(.milliseconds(1000)) {
            //  self.onTapTakePhoto(self);
            //}
            
        }
    }
    
    /// - Tag: PreprocessImage
    func scaleAndOrient(image: UIImage) -> UIImage {
        
        // Set a default value for limiting image size.
        let maxResolution: CGFloat = 640
        
        guard let cgImage = image.cgImage else {
            print("UIImage has no CGImage backing it!")
            return image
        }
        
        // Compute parameters for transform.
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        
        let orientation = image.imageOrientation
        
        let transform = self.graphImageParams(orientation: orientation, width: width, height: height).0
        
        let bounds = self.graphImageParams(orientation: orientation, width: width, height: height).1
        
        let scaleRatio = bounds.size.width / width
//        switch orientation {
//        case .up:
//            transform = .identity
//        case .down:
//            transform = CGAffineTransform(translationX: width, y: height).rotated(by: .pi)
//        case .left:
//            let boundsHeight = bounds.size.height
//            bounds.size.height = bounds.size.width
//            bounds.size.width = boundsHeight
//            transform = CGAffineTransform(translationX: 0, y: width).rotated(by: 3.0 * .pi / 2.0)
//        case .right:
//            let boundsHeight = bounds.size.height
//            bounds.size.height = bounds.size.width
//            bounds.size.width = boundsHeight
//            transform = CGAffineTransform(translationX: height, y: 0).rotated(by: .pi / 2.0)
//        case .upMirrored:
//            transform = CGAffineTransform(translationX: width, y: 0).scaledBy(x: -1, y: 1)
//        case .downMirrored:
//            transform = CGAffineTransform(translationX: 0, y: height).scaledBy(x: 1, y: -1)
//        case .leftMirrored:
//            let boundsHeight = bounds.size.height
//            bounds.size.height = bounds.size.width
//            bounds.size.width = boundsHeight
//            transform = CGAffineTransform(translationX: height, y: width).scaledBy(x: -1, y: 1).rotated(by: 3.0 * .pi / 2.0)
//        case .rightMirrored:
//            let boundsHeight = bounds.size.height
//            bounds.size.height = bounds.size.width
//            bounds.size.width = boundsHeight
//            transform = CGAffineTransform(scaleX: -1, y: 1).rotated(by: .pi / 2.0)
     //   }
        
        return UIGraphicsImageRenderer(size: bounds.size).image { rendererContext in
            let context = rendererContext.cgContext
            
            if orientation == .right || orientation == .left {
                context.scaleBy(x: -scaleRatio, y: scaleRatio)
                context.translateBy(x: -height, y: 0)
            } else {
                context.scaleBy(x: scaleRatio, y: -scaleRatio)
                context.translateBy(x: 0, y: -height)
            }
            context.concatenate(transform)
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }
    }
    
    func graphImageParams(orientation: UIImage.Orientation, width: CGFloat, height: CGFloat) -> (CGAffineTransform, CGRect){
        var transform = CGAffineTransform.identity
        
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        switch orientation {
        case .up:
            transform = .identity
        case .down:
            transform = CGAffineTransform(translationX: width, y: height).rotated(by: .pi)
        case .left:
            let boundsHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundsHeight
            transform = CGAffineTransform(translationX: 0, y: width).rotated(by: 3.0 * .pi / 2.0)
        case .right:
            let boundsHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundsHeight
            transform = CGAffineTransform(translationX: height, y: 0).rotated(by: .pi / 2.0)
        case .upMirrored:
            transform = CGAffineTransform(translationX: width, y: 0).scaledBy(x: -1, y: 1)
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0, y: height).scaledBy(x: 1, y: -1)
        case .leftMirrored:
            let boundsHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundsHeight
            transform = CGAffineTransform(translationX: height, y: width).scaledBy(x: -1, y: 1).rotated(by: 3.0 * .pi / 2.0)
        case .rightMirrored:
            let boundsHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundsHeight
            transform = CGAffineTransform(scaleX: -1, y: 1).rotated(by: .pi / 2.0)
        }
        
        return(transform, bounds)
    }
    
    // MARK:- API
    func callAPI(patternImage: UIImage, barcodeImage: UIImage){
        
        var barcodeImage = barcodeImage
        
        if let imageAfterResize = patternImage.resize(withWidth: 200, aheight: 200){
            if let imageData:Data =  imageAfterResize.pngData(){
                let base64String = imageData.base64EncodedString()
                add(loadingViewController)
                self.router.serviceForEndPointVersionTwo(apiType: .processImagePattern(imageBase64: base64String), decodingType: ImagePatternResponse.self) {[weak self] (result) in
                    DispatchQueue.main.async {
                        self?.loadingViewController.remove()
                    }
                    switch result {
                    case .success(let responseData, let model):
                        guard let response = responseData else {return}
                        if  response.success {
                            if let imagePattern = model{
                                DispatchQueue.main.async {
                                    if let barcode = self?.qrcodeData?.genrateQrCode(){
                                        barcodeImage = barcode
                                    }
                                    self?.pushToPatternDetailViewController(imagePattern, qrId: self?.qrcodeData, qrImage: barcodeImage)
                                }
                            }
                        }else {
                            DispatchQueue.main.async {
                                self?.showToastOnTop(message: response.message ?? "")
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.showToastOnTop(message: error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

extension UIInterfaceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeRight: return .landscapeRight
        case .landscapeLeft: return .landscapeLeft
        case .portrait: return .portrait
        default: return nil
        }
    }
}

extension DispatchQueue {
    static func delay(_ delay: DispatchTimeInterval, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
}


