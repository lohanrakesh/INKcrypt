//
//  ReportDetailViewController.swift
//  INKcrypt
//
//  Created by Asif on 11/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

class ReportDetailViewController: ViewController {
    //Outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bioMarkerIdLabel: UILabel!
    @IBOutlet weak var ilnLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var smartQrCodeIdLabel: UILabel!
    
    var markerData : MapInfoWindowModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        let camera = GMSCameraPosition.camera(withLatitude: markerData?.latitude ?? 0.0, longitude: markerData?.longitude ?? 0.0, zoom: 16.0)
        mapView.camera = camera
        showMarker(position: camera.target)

        // Do any additional setup after loading the view.
    }
    // MARK: - Custom Method
    private func initializeView() {
        self.title = PageTitleStrings.report.localized
        bioMarkerIdLabel.text = markerData?.bioMarkerID
        ilnLabel.text = markerData?.itemLabel
        descriptionLabel.text = markerData?.description
        resultLabel.text = markerData?.result
        dateLabel.text = markerData?.date
        timeLabel.text = markerData?.time
        statusLabel.text = markerData?.status
        locationLabel.text = markerData?.location
        commentLabel.text = markerData?.comment
        emailLabel.text = markerData?.email
        smartQrCodeIdLabel.text = markerData?.smartQrCodeId
    }

    private func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = markerData?.itemLabel
        marker.snippet =  markerData?.description
        marker.map = mapView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
