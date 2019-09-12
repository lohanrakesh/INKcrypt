//
//  AuthenticateViewController+ImagePickerExtension.swift
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

extension AuthenticateViewController {
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        // Extract chosen image.
        imageView1.image = nil;
        imageView2.image = nil;
        guard let originalImage = info[.originalImage] as? UIImage else {
            return
        }
        //let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // Display image on screen.
        show(originalImage)
        
        // Convert from UIImageOrientation to CGImagePropertyOrientation.
        //let cgOrientation = CGImagePropertyOrientation(rawValue: UInt32(originalImage.imageOrientation.rawValue))
        let cgOrientation = CGImagePropertyOrientation.init(originalImage.imageOrientation);
        // Fire off request based on URL of chosen photo.
        guard let cgImage = originalImage.cgImage else {
            return
        }
        performVisionRequest(image: cgImage,
                             orientation: cgOrientation)
        
        // Dismiss the picker to return to original view controller.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss picker, returning to original root viewController.
        dismiss(animated: true, completion: nil)
        
    }
    
    /*internal func imagePickerController(_ picker: UIImagePickerController,
     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
     // Extract chosen image.
     let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
     
     // Display image on screen.
     show(originalImage)
     
     // Convert from UIImageOrientation to CGImagePropertyOrientation.
     let cgOrientation = CGImagePropertyOrientation(originalImage.imageOrientation)
     
     // Fire off request based on URL of chosen photo.
     guard let cgImage = originalImage.cgImage else {
     return
     }
     performVisionRequest(image: cgImage,
     orientation: cgOrientation)
     
     // Dismiss the picker to return to original view controller.
     dismiss(animated: true, completion: nil)
     }*/
    
    func show(_ image: UIImage) {
        
        // Remove previous paths & image
        pathLayer?.removeFromSuperlayer()
        pathLayer = nil
        imageView.image = nil
        
        // Account for image orientation by transforming view.
        let correctedImage = image//scaleAndOrient(image: image)
        
        // Place photo inside imageView.
        imageView.image = correctedImage.resize(withWidth: image.size.width, aheight: image.size.height)
        
        // Transform image to fit screen.
        guard let cgImage = correctedImage.cgImage else {
            print("Trying to show an image not backed by CGImage!")
            return
        }
        
        let fullImageWidth = CGFloat(cgImage.width)
        let fullImageHeight = CGFloat(cgImage.height)
        
        let imageFrame = imageView.frame
        let widthRatio = fullImageWidth / imageFrame.width
        let heightRatio = fullImageHeight / imageFrame.height
        
        // ScaleAspectFit: The image will be scaled down according to the stricter dimension.
        let scaleDownRatio = max(widthRatio, heightRatio)
        
        // Cache image dimensions to reference when drawing CALayer paths.
        imageWidth = fullImageWidth / scaleDownRatio
        imageHeight = fullImageHeight / scaleDownRatio
        
        // Prepare pathLayer to hold Vision results.
        let xLayer = (imageFrame.width - imageWidth) / 2
        let yLayer = imageView.frame.minY + (imageFrame.height - imageHeight) / 2
        let drawingLayer = CALayer()
        drawingLayer.bounds = CGRect(x: xLayer, y: yLayer, width: imageWidth, height: imageHeight)
        drawingLayer.anchorPoint = CGPoint.zero
        drawingLayer.position = CGPoint(x: xLayer, y: yLayer)
        drawingLayer.opacity = 0.5
        pathLayer = drawingLayer
        self.view.layer.addSublayer(pathLayer!)
}
}

extension UIImage {
    /**
     Creates a new UIImage from a CVPixelBuffer.
     NOTE: This only works for RGB pixel buffers, not for grayscale.
     */
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
        
        if let cgImage = cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
    
    func getPixelColor(pos: CGPoint) -> UIColor? {
        guard let pixelData = self.cgImage?.dataProvider?.data else { return nil }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x))
        
        var red = CGFloat(data[pixelInfo])
        var green = CGFloat(data[pixelInfo+1])
        var blue = CGFloat(data[pixelInfo+2])
        var alpha = CGFloat(data[pixelInfo+3])
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func resize(withWidth newWidth: CGFloat, aheight:CGFloat ) -> UIImage? {
        
        _ = newWidth / self.size.width
        let newHeight = aheight
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension CGMutablePath {
    // Helper function to add lines to a path.
    func addPoints(in landmarkRegion: VNFaceLandmarkRegion2D,
                   applying affineTransform: CGAffineTransform,
                   closingWhenComplete closePath: Bool) {
        let pointCount = landmarkRegion.pointCount
        
        // Draw line if and only if path contains multiple points.
        guard pointCount > 1 else {
            return
        }
        self.addLines(between: landmarkRegion.normalizedPoints, transform: affineTransform)
        
        if closePath {
            self.closeSubpath()
        }
    }
}

extension AuthenticateViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let originalImage = UIImage(pixelBuffer: pixelBuffer)
        let cgOrientation = CGImagePropertyOrientation.init((originalImage?.imageOrientation)!);
        var correctedImage = scaleAndOrient(image: originalImage!)
        correctedImage = correctedImage.resize(withWidth: 3024, aheight: 4032)!
        
        guard let cgImage = correctedImage.cgImage else {
            return
        }
        
        
        
        performVisionRequest(image: cgImage,
                             orientation: cgOrientation)
        
        //        var requestOptions:[VNImageOption : Any] = [:]
        //
        //        if let camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
        //            requestOptions = [.cameraIntrinsics:camData]
        //        }
        //
        //
        //
        //        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: cgOrientation, options: requestOptions)
        //
        //        do {
        //            try imageRequestHandler.perform(self.requests)
        //        } catch {
        //            print(error)
        //        }
    }
}


extension AuthenticateViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is contains at least one object.
        if metadataObjects.count == 0 {
            
            return
        }
        
        // Get the metadata object.
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            
            
        }
    }
}


