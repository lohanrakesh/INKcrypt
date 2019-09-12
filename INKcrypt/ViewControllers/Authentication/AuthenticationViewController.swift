//
//  AuthenticationViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 21/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Photos
import UIKit
import Vision
import AVFoundation
import VideoToolbox

class AuthenticationViewController: ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scannerView: UIImageView!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var patternCodeImageView: UIImageView!
    @IBOutlet weak var scanQrView: UIView!
    @IBOutlet weak var manualQrView: UIView!
    @IBOutlet weak var scanQrButtonBaseView: UIView!
    @IBOutlet weak var manualQrButtonBaseView: UIView!
    @IBOutlet weak var manualQrCodeTextField: UITextField!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var qrCodeFrameView: UIView?
    var imagePatternFrameView: UIView?
    var qrcodeData: String?
    
    var isPhotoCaptured = false
    var isFlashOn = false
    
    
    // MARK:- View Cycle
    override func viewDidLoad() {
        print("check 23434234")
        super.viewDidLoad()
        //        let logo = UIImage(named: "inkcrypt_home-logo")
        //        let imageView = UIImageView(image:logo)
        //        self.navigationItem.titleView = imageView
        
        //captureButton.layer.cornerRadius = captureButton.frame.size.width / 2
        // captureButton.clipsToBounds = true
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter
        self.initializeView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.restartSession()
        self.scanQrHidden()
    }
    
    override func viewDidLayoutSubviews() {
        videoPreviewLayer?.frame = view.bounds
        if let previewLayer = videoPreviewLayer ,(previewLayer.connection?.isVideoOrientationSupported)! {
            previewLayer.connection?.videoOrientation = UIApplication.shared.statusBarOrientation.videoOrientation ?? .portrait
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let vc = segue.destination as! DetailViewController
        //        vc.qrcodeurl = qrcodeData//messageLabel.text
    }
    
    func scanQrHidden(){
        self.view.endEditing(true)
        self.scanQrView.isHidden = false
        self.scanQrButtonBaseView.isHidden = false
        self.manualQrView.isHidden = true
        self.manualQrButtonBaseView.isHidden = true
    }
    
    func manualQrHidden(){
        self.view.endEditing(true)
        self.qrCodeFrameView?.removeFromSuperview()
        self.imagePatternFrameView?.removeFromSuperview()
        self.scanQrView.isHidden = true
        self.scanQrButtonBaseView.isHidden = true
        self.manualQrView.isHidden = false
        self.manualQrButtonBaseView.isHidden = false
    }
    
    // MARK:- Custom Method
    func initializeView() {
        self.title = PageTitleStrings.authentication.localized
        
        self.scannerView.contentMode = .scaleAspectFill
        self.startSession()
    }
    
    func startSession(){
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            fatalError("No video device found")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous deivce object
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object
            captureSession = AVCaptureSession()
            
            // Set the input devcie on the capture session
            captureSession?.addInput(input)
            
            // Get an instance of ACCapturePhotoOutput class
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            
            // Set the output on the capture session
            captureSession?.addOutput(capturePhotoOutput!)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the input device
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            //Initialise the video preview layer and add it as a sublayer to the viewPreview view's layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = previewView.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer!)
            
            //start video capture
            captureSession?.startRunning()
            let scanRect = scannerView.frame
            let rectOfInterest = videoPreviewLayer?.metadataOutputRectConverted(fromLayerRect: scanRect)
            captureMetadataOutput.rectOfInterest = rectOfInterest!
            
            //messageLabel.isHidden = true
            
            //Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            imagePatternFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            if let imagePatternFrameView = imagePatternFrameView {
                imagePatternFrameView.layer.borderColor = UIColor.red.cgColor
                imagePatternFrameView.layer.borderWidth = 2
                view.addSubview(imagePatternFrameView)
                view.bringSubviewToFront(imagePatternFrameView)
            }
            
        } catch {
            //If any error occurs, simply print it out
            print(error)
            return
        }
    }
    
    func restartSession(){
        if !(captureSession?.isRunning)!{
            captureSession?.startRunning()
        }
        qrCodeFrameView?.frame = CGRect.zero
        imagePatternFrameView?.frame = CGRect.zero
        self.qrCodeImageView.image = nil
        self.patternCodeImageView.image = nil
        self.isPhotoCaptured = false
    }
    
    // MARK: - Action
    
    //    @IBAction func scanQRCodeButtonClicked(sender: UIButton){
    //        self.pushToPatternDetailViewController()
    //
    //    }
    
    @IBAction func enterManuallyButtonClicked(sender: UIButton){
       // self.pushToTestResultViewController()
        self.manualQrHidden()
        self.captureSession?.stopRunning()
        self.startSession()
    }
    
    @IBAction func scanButtonClicked(sender: UIButton){
        //self.pushToTestResultViewController()
        self.scanQrHidden()
        self.captureSession?.startRunning()
    }
    
    @IBAction func authenticateButtonClicked(_ sender: Any){
        
        if let qrCode = self.manualQrCodeTextField.text, !qrCode.isEmpty {
            self.view.endEditing(true)
            self.pushToPatternDetailViewController(nil, qrId: qrCode, qrImage: nil)
        }else {
           self.showToastOnTop(message: AlertMessages.enterQRCode.localized)
        }
    }
    
    @IBAction func flashButtonClicked(_ sender: Any) {
        self.isFlashOn = !self.isFlashOn
    }
    
    @IBAction func onTapTakePhoto(_ sender: Any) {
        
        // Make sure capturePhotoOutput is valid
        guard let capturePhotoOutput = self.capturePhotoOutput else { return
            
        }
        
        // Get an instance of AVCapturePhotoSettings class
        let photoSettings = AVCapturePhotoSettings()
        
        // Set photo settings for our need
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        if self.isFlashOn {
           photoSettings.flashMode = .on
        }else {
            photoSettings.flashMode = .off
        }
        
        // Call capturePhoto method by passing our photo settings and a delegate implementing AVCapturePhotoCaptureDelegate
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}

extension AuthenticationViewController : AVCapturePhotoCaptureDelegate {
    
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else{
            return
        }
        
        self.isPhotoCaptured = true
        self.captureSession?.stopRunning()
        // Initialise an UIImage with our image data
        // let capturedImage = self.scaleAndOrient(image: UIImage.init(data: imageData)!)
        
        //let capturedImage = UIImage.init(data: imageData)!
        
        let capturedImage = self.resizedImageWith(image: UIImage.init(data: imageData)!, targetSize: (self.videoPreviewLayer?.frame.size)!)
        
        let scale = UIScreen.main.scale
        
        let qrFrame = CGRect.init(x: (qrCodeFrameView?.frame.origin.x)! * scale, y: (qrCodeFrameView?.frame.origin.y)! * scale + 14.0, width: (qrCodeFrameView?.frame.size.width)! * scale, height: (qrCodeFrameView?.frame.size.height)! * scale)
        
        var qrImage: UIImage!
        if let cgImage = capturedImage.cgImage, let qrCroppedCGImage = cgImage.cropping(to: qrFrame) {
            
            qrImage =  UIImage(cgImage: qrCroppedCGImage)
            
            qrCodeImageView.image = qrImage
        }else {
            self.restartSession()
            return
        }
        
        
        let patternFrame = CGRect.init(x: (imagePatternFrameView?.frame.origin.x)! * scale, y: (imagePatternFrameView?.frame.origin.y)! * scale + 2.0, width: (imagePatternFrameView?.frame.size.width)! * scale, height: (imagePatternFrameView?.frame.size.height)! * scale - 2.0)
        
        var patternImage: UIImage?
        if let cgImage = capturedImage.cgImage, let patternCroppedCGImage = cgImage.cropping(to: patternFrame) {
            
            patternImage =  UIImage(cgImage: patternCroppedCGImage).resize(withWidth: 200, aheight: 200)
            
            patternCodeImageView.image = patternImage
        }else {
            self.restartSession()
            return
        }
        if let image = patternImage{
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.callAPI(patternImage: image, barcodeImage: qrImage)
        }
        
    }
    
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?) {
        // Make sure we get some photo sample buffer
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else {
                print("Error capturing photo: \(String(describing: error))")
                return
        }
        
        // Convert photo same buffer to a jpeg image data by using AVCapturePhotoOutput
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }
        
        self.isPhotoCaptured = true
        self.captureSession?.stopRunning()
        // Initialise an UIImage with our image data
        // let capturedImage = self.scaleAndOrient(image: UIImage.init(data: imageData)!)
        
        //let capturedImage = UIImage.init(data: imageData)!
        
        let capturedImage = self.resizedImageWith(image: UIImage.init(data: imageData)!, targetSize: (self.videoPreviewLayer?.frame.size)!)
        
        let scale = UIScreen.main.scale
        
        let qrFrame = CGRect.init(x: (qrCodeFrameView?.frame.origin.x)! * scale, y: (qrCodeFrameView?.frame.origin.y)! * scale + 14.0, width: (qrCodeFrameView?.frame.size.width)! * scale, height: (qrCodeFrameView?.frame.size.height)! * scale)
        
        var qrImage: UIImage!
        if let cgImage = capturedImage.cgImage, let qrCroppedCGImage = cgImage.cropping(to: qrFrame) {
            
            qrImage =  UIImage(cgImage: qrCroppedCGImage)
            
            qrCodeImageView.image = qrImage
        }else {
            self.restartSession()
            return
        }
        
        
        let patternFrame = CGRect.init(x: (imagePatternFrameView?.frame.origin.x)! * scale, y: (imagePatternFrameView?.frame.origin.y)! * scale + 10.0, width: (imagePatternFrameView?.frame.size.width)! * scale, height: (imagePatternFrameView?.frame.size.height)! * scale)
        
        var patternImage: UIImage!
        if let cgImage = capturedImage.cgImage, let patternCroppedCGImage = cgImage.cropping(to: patternFrame) {
            
            patternImage =  UIImage(cgImage: patternCroppedCGImage)
            
            patternCodeImageView.image = patternImage
        }else {
            self.restartSession()
            return
        }
        UIImageWriteToSavedPhotosAlbum(patternImage, nil, nil, nil)
        self.callAPI(patternImage: patternImage, barcodeImage: qrImage)
    }
    
    
    func resizedImageWith(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let imageSize = image.size
        let newWidth  = targetSize.width  / image.size.width
        let newHeight = targetSize.height / image.size.height
        var newSize: CGSize
        
        if newWidth > newHeight {
            newSize = CGSize.init(width: imageSize.width * newHeight, height: imageSize.width * newHeight)
        } else {
            newSize = CGSize.init(width: imageSize.width * newHeight, height:  imageSize.height * newWidth)
        }
        
        let rect = CGRect.init(x: 0.0, y: 0.0, width: targetSize.width, height: targetSize.height)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
