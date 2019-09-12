//
//  AuthenticateViewController+Extension.swift
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
    func handleDetectedRectangles(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            self.presentAlert("Rectangle Detection Error", error: nsError)
            return
        }
        // Since handlers are executing on a background thread, explicitly send draw calls to the main thread.
        DispatchQueue.main.async {
            guard let drawLayer = self.pathLayer,
                let results = request?.results as? [VNRectangleObservation] else {
                    return
            }
            self.draw(rectangles: results, onImageWithBounds: drawLayer.bounds)
            drawLayer.setNeedsDisplay()
        }
    }
    
    func handleDetectedFaces(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            self.presentAlert("Face Detection Error", error: nsError)
            return
        }
        // Perform drawing on the main thread.
        DispatchQueue.main.async {
            guard let drawLayer = self.pathLayer,
                let results = request?.results as? [VNFaceObservation] else {
                    return
            }
            self.draw(faces: results, onImageWithBounds: drawLayer.bounds)
            drawLayer.setNeedsDisplay()
        }
    }
    
    func handleDetectedFaceLandmarks(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            self.presentAlert("Face Landmark Detection Error", error: nsError)
            return
        }
        // Perform drawing on the main thread.
        DispatchQueue.main.async {
            guard let drawLayer = self.pathLayer,
                let results = request?.results as? [VNFaceObservation] else {
                    return
            }
            self.drawFeatures(onFaces: results, onImageWithBounds: drawLayer.bounds)
            drawLayer.setNeedsDisplay()
        }
    }
    
    func handleDetectedText(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            self.presentAlert("Text Detection Error", error: nsError)
            return
        }
        // Perform drawing on the main thread.
        DispatchQueue.main.async {
            guard let drawLayer = self.pathLayer,
                let results = request?.results as? [VNTextObservation] else {
                    return
            }
            self.draw(text: results, onImageWithBounds: drawLayer.bounds)
            drawLayer.setNeedsDisplay()
        }
    }
    
    func handleDetectedBarcodes(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            self.presentAlert("Barcode Detection Error", error: nsError)
            return
        }
        // Perform drawing on the main thread.
        DispatchQueue.main.async {
            guard let drawLayer = self.pathLayer,
                let results = request?.results as? [VNBarcodeObservation] else {
                    return
            }
            self.draw(barcodes: results, onImageWithBounds: drawLayer.bounds)
            drawLayer.setNeedsDisplay()
        }
    }
    
    
    
    // MARK: - Path-Drawing
    
    fileprivate func boundingBox(forRegionOfInterest: CGRect, withinImageBounds bounds: CGRect) -> CGRect {
        
        let imageWidth = bounds.width
        let imageHeight = bounds.height
        
        // Begin with input rect.
        var rect = forRegionOfInterest
        
        // Reposition origin.
        rect.origin.x *= imageWidth
        rect.origin.x += bounds.origin.x
        rect.origin.y = (1 - rect.origin.y) * imageHeight + bounds.origin.y
        
        // Rescale normalized coordinates.
        rect.size.width *= imageWidth
        rect.size.height *= imageHeight
        
        return rect
    }
    
    fileprivate func boundingBoxForPattern(forRegionOfInterest: CGRect, withinImageBounds bounds: CGRect) -> CGRect {
        
        let imageWidth = bounds.width
        let imageHeight = bounds.height
        
        // Begin with input rect.
        var rect = forRegionOfInterest
        
        // Reposition origin.
        
        
        
        rect.origin.x *= imageWidth
        rect.origin.x += bounds.origin.x
        rect.origin.y = (1 - rect.origin.y) * imageHeight + bounds.origin.y
        
        // Rescale normalized coordinates.
        rect.size.width *= imageWidth
        rect.size.height *= imageHeight
        
        return rect
    }
    
    fileprivate func shapeLayer(color: UIColor, frame: CGRect) -> CAShapeLayer {
        // Create a new layer.
        let layer = CAShapeLayer()
        
        // Configure layer's appearance.
        layer.fillColor = nil // No fill to show boxed object
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
        layer.borderWidth = 2
        
        // Vary the line color according to input.
        layer.borderColor = color.cgColor
        
        // Locate the layer.
        layer.anchorPoint = .zero
        layer.frame = frame
        layer.masksToBounds = true
        
        // Transform the layer to have same coordinate system as the imageView underneath it.
        layer.transform = CATransform3DMakeScale(1, -1, 1)
        
        return layer
    }
    
    // Rectangles are BLUE.
    fileprivate func draw(rectangles: [VNRectangleObservation], onImageWithBounds bounds: CGRect) {
        CATransaction.begin()
        for observation in rectangles {
            let rectBox = boundingBox(forRegionOfInterest: observation.boundingBox, withinImageBounds: bounds)
            let rectLayer = shapeLayer(color: .blue, frame: rectBox)
            
            // Add to pathLayer on top of image.
            pathLayer?.addSublayer(rectLayer)
        }
        CATransaction.commit()
    }
    
    // Faces are YELLOW.
    /// - Tag: DrawBoundingBox
    fileprivate func draw(faces: [VNFaceObservation], onImageWithBounds bounds: CGRect) {
        CATransaction.begin()
        for observation in faces {
            let faceBox = boundingBox(forRegionOfInterest: observation.boundingBox, withinImageBounds: bounds)
            let faceLayer = shapeLayer(color: .yellow, frame: faceBox)
            
            // Add to pathLayer on top of image.
            pathLayer?.addSublayer(faceLayer)
        }
        CATransaction.commit()
    }
    
    // Facial landmarks are GREEN.
    fileprivate func drawFeatures(onFaces faces: [VNFaceObservation], onImageWithBounds bounds: CGRect) {
        CATransaction.begin()
        for faceObservation in faces {
            let faceBounds = boundingBox(forRegionOfInterest: faceObservation.boundingBox, withinImageBounds: bounds)
            guard let landmarks = faceObservation.landmarks else {
                continue
            }
            
            // Iterate through landmarks detected on the current face.
            let landmarkLayer = CAShapeLayer()
            let landmarkPath = CGMutablePath()
            let affineTransform = CGAffineTransform(scaleX: faceBounds.size.width, y: faceBounds.size.height)
            
            // Treat eyebrows and lines as open-ended regions when drawing paths.
            let openLandmarkRegions: [VNFaceLandmarkRegion2D?] = [
                landmarks.leftEyebrow,
                landmarks.rightEyebrow,
                landmarks.faceContour,
                landmarks.noseCrest,
                landmarks.medianLine
            ]
            
            // Draw eyes, lips, and nose as closed regions.
            let closedLandmarkRegions = [
                landmarks.leftEye,
                landmarks.rightEye,
                landmarks.outerLips,
                landmarks.innerLips,
                landmarks.nose
                ].compactMap { $0 } // Filter out missing regions.
            
            // Draw paths for the open regions.
            for openLandmarkRegion in openLandmarkRegions where openLandmarkRegion != nil {
                landmarkPath.addPoints(in: openLandmarkRegion!,
                                       applying: affineTransform,
                                       closingWhenComplete: false)
            }
            
            // Draw paths for the closed regions.
            for closedLandmarkRegion in closedLandmarkRegions {
                landmarkPath.addPoints(in: closedLandmarkRegion,
                                       applying: affineTransform,
                                       closingWhenComplete: true)
            }
            
            // Format the path's appearance: color, thickness, shadow.
            landmarkLayer.path = landmarkPath
            landmarkLayer.lineWidth = 2
            landmarkLayer.strokeColor = UIColor.green.cgColor
            landmarkLayer.fillColor = nil
            landmarkLayer.shadowOpacity = 0.75
            landmarkLayer.shadowRadius = 4
            
            // Locate the path in the parent coordinate system.
            landmarkLayer.anchorPoint = .zero
            landmarkLayer.frame = faceBounds
            landmarkLayer.transform = CATransform3DMakeScale(1, -1, 1)
            
            // Add to pathLayer on top of image.
            pathLayer?.addSublayer(landmarkLayer)
        }
        CATransaction.commit()
    }
    
    // Lines of text are RED.  Individual characters are PURPLE.
    fileprivate func draw(text: [VNTextObservation], onImageWithBounds bounds: CGRect) {
        CATransaction.begin()
        for wordObservation in text {
            let wordBox = boundingBox(forRegionOfInterest: wordObservation.boundingBox, withinImageBounds: bounds)
            let wordLayer = shapeLayer(color: .red, frame: wordBox)
            
            // Add to pathLayer on top of image.
            pathLayer?.addSublayer(wordLayer)
            
            // Iterate through each character within the word and draw its box.
            guard let charBoxes = wordObservation.characterBoxes else {
                continue
            }
            for charObservation in charBoxes {
                let charBox = boundingBox(forRegionOfInterest: charObservation.boundingBox, withinImageBounds: bounds)
                let charLayer = shapeLayer(color: .purple, frame: charBox)
                charLayer.borderWidth = 1
                
                // Add to pathLayer on top of image.
                pathLayer?.addSublayer(charLayer)
            }
        }
        CATransaction.commit()
    }
    
    // Barcodes are ORANGE.
    fileprivate func draw(barcodes: [VNBarcodeObservation], onImageWithBounds bounds: CGRect) {
        CATransaction.begin()
        for observation in barcodes {
            let barcodeBox = boundingBox(forRegionOfInterest: observation.boundingBox, withinImageBounds: bounds)
            let barcodeLayer = shapeLayer(color: .orange, frame: barcodeBox)
            let barcodeBox1 = boundingBox(forRegionOfInterest: observation.boundingBox, withinImageBounds: imageView.frame)
            let width = observation.boundingBox.width * CGFloat((imageView.image?.size.width)!)
            let height = observation.boundingBox.height * CGFloat((imageView.image?.size.height)!)
            let xCoordinate = observation.boundingBox.origin.x * CGFloat((imageView.image?.size.width)!)
            let yCoordinate = (1 - observation.boundingBox.origin.y) * CGFloat((imageView.image?.size.height)!) - height
            
            let croppingRect = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: height)
            
            let croppedImage = self.cropImage(image: imageView.image!, cropRect: croppingRect) //UIImage(cgImage: croppedCGImage)
            let croppedCGImage:CGImage = (imageView.image!.cgImage?.cropping(to: croppingRect))!
            let barcodeImage = UIImage(cgImage: croppedCGImage)
            imageView1.image = barcodeImage
            let width1 = (width)*1.23
            let height1 = (height)*1.32
            let xCoordinate1 = xCoordinate - (width * 0.103) //(x)*0.97
            let yCoordinate1 = (yCoordinate) + height + (height * 0.051)
            
            let croppingRect1 = CGRect(x: xCoordinate1, y: yCoordinate1, width: width1, height: height1)
            let croppedCGImage1:CGImage = (imageView.image!.cgImage?.cropping(to: croppingRect1))!
            let barcodeImage1 = UIImage(cgImage: croppedCGImage1)
            if let imageAfterResize = barcodeImage1.resize(withWidth: 200, aheight: 200){
                imageView2.image = imageAfterResize
                if let imageData:Data =  imageAfterResize.pngData(){
                    let base64String = imageData.base64EncodedString()
                    
                    add(loadingViewController)
                    self.networkClient.processImage(image: base64String) {[weak self] (repsonse, message) in
                        DispatchQueue.main.async {
                            self?.loadingViewController.remove()
                        }
                        if let imagePattern = repsonse{
                            DispatchQueue.main.async {
                                self?.pushToPatternDetailViewController(imagePattern, qrId: observation.payloadStringValue, qrImage: barcodeImage)
                            }
                            
                        }else if let message = message{
                            debugPrint(message)
                        }
                    }
                }
            }
        }
        CATransaction.commit()
    }
    
    func findColors(_ image: UIImage) -> [UIColor] {
        let pixelsWide = Int(image.size.width)
        let pixelsHigh = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return [] }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var imageColors: [UIColor] = []
        for xCoordinate in 0..<pixelsWide {
            for yCoordinate in 0..<pixelsHigh {
                let center = CGPoint(x: xCoordinate, y: yCoordinate)
                let pixelInfo: Int = ((pixelsWide * Int(center.y)) + Int(center.x)) * 2
                let red = CGFloat(data[pixelInfo])
                let green = CGFloat(data[pixelInfo + 1])
                let blue = CGFloat(data[pixelInfo + 2])
                
                let color = UIColor(red: CGFloat(data[pixelInfo]) / 255.0,
                                    green: CGFloat(data[pixelInfo + 1]) / 255.0,
                                    blue: CGFloat(data[pixelInfo + 2]) / 255.0,
                                    alpha: CGFloat(data[pixelInfo + 3]) / 255.0)
                if center.x == 80 && center.y == 46 {
                    let color = UIColor(red: CGFloat(data[pixelInfo]) / 255.0,
                                        green: CGFloat(data[pixelInfo + 1]) / 255.0,
                                        blue: CGFloat(data[pixelInfo + 2]) / 255.0,
                                        alpha: CGFloat(data[pixelInfo + 3]) / 255.0)
                    imageColors.append(color)
                }
            }
        }
        return imageColors
    }
    
    private func cropImage( image:UIImage , cropRect:CGRect) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(cropRect.size, false, 0);
        let context = UIGraphicsGetCurrentContext();
        
        context?.translateBy(x: 0.0, y: image.size.height);
        context?.scaleBy(x: 1.0, y: -1.0);
        context?.draw(image.cgImage!, in: CGRect(x:0, y:0, width:image.size.width, height:image.size.height), byTiling: false);
        context?.clip(to: [cropRect]);
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return croppedImage!;
    }
}
