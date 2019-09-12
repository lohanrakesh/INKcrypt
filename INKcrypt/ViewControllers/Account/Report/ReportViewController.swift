//
//  ReportViewController.swift
//  INKcrypt
//
//  Created by Asif on 11/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

enum ReportType {
    case list
    case map
}

enum TestsType {
    case onMyINKcryptIDs
    case iHavePerformed
}


public struct MapInfoWindowModel {
    let bioMarkerID: String
    let itemLabel: String
    let description: String
    let result: String
    let date: String
    let time: String
    let status: String
    let latitude : CLLocationDegrees
    let longitude : CLLocationDegrees
    let location: String
    let comment: String
    let email: String
    let smartQrCodeId: String
    let typeOfTests: TestsType

}

class ReportViewController: ViewController{
    //Outlets
    @IBOutlet weak var reportTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var selectedSegmentLineLeading: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    var reportType = ReportType.list
    var mapButton : UIBarButtonItem!
    var listButton : UIBarButtonItem!
    var filterButton : UIBarButtonItem!
    var shareButton : UIBarButtonItem!
    private var tappedMarker : GMSMarker?
    fileprivate var customInfoWindow : ReportMapMarkerWindow?
    var mapInfo = [MapInfoWindowModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapInfo = [
            MapInfoWindowModel(bioMarkerID: "AB14G671MR", itemLabel: "Q3 Infotech", description: "Connector. SKU 5698", result: "Pass", date: "15/Apr/19", time: "2:00 PM", status: "Active", latitude: 28.4194, longitude: 77.0382, location: "JMD Megapolies", comment: "Yoo", email: "q3tech@gmail.com", smartQrCodeId: "MOP635W", typeOfTests: TestsType.onMyINKcryptIDs),
            MapInfoWindowModel(bioMarkerID: "BB14G671MR", itemLabel: "Raheja Mall", description: "Connector. SKU 9563", result: "Invalide", date: "15/Apr/19", time: "2:10 PM", status: "Active", latitude: 28.4236, longitude: 77.0395,location: "Raheja", comment: "Nice Place", email: "raheja@gmail.com", smartQrCodeId: "PQR12T", typeOfTests: TestsType.onMyINKcryptIDs),
            MapInfoWindowModel(bioMarkerID: "CB14G671MR", itemLabel: "Nexa Rajeev Chawk", description: "Connector. SKU 14653", result: "Fail", date: "15/Apr/19", time: "2:30 PM", status: "Active", latitude: 28.4485, longitude: 77.0245,location: "Rajeev Chawk", comment: "Awesome Workshop", email: "nexa@gmail.com", smartQrCodeId: "NJ7HG4", typeOfTests: TestsType.iHavePerformed)
        ]
        self.initializeView()
        self.setupViewType()
        self.setupRightBarButton()
        self.setSegmentControlTextAppearance()
        
    }
    
    /// This func use to load custom view to show on map marker info window
    ///
    /// - Returns: custom info window
    private func loadNiB() -> ReportMapMarkerWindow? {
        let infoWindow = ReportMapMarkerWindow.instanceFromNib() as? ReportMapMarkerWindow
        return infoWindow
    }
    
    private func loadMarkers() {
        if segmentControl.selectedSegmentIndex == 0 {
            setMarkerOnMap(markerArray: mapInfo.filter({$0.typeOfTests == TestsType.onMyINKcryptIDs}))
        } else {
            setMarkerOnMap(markerArray: mapInfo.filter({$0.typeOfTests == TestsType.iHavePerformed}))
        }
        self.tappedMarker = GMSMarker()
        self.customInfoWindow = loadNiB()
        self.mapView.delegate = self
        
    }
    
    /// This func use to insert markers on map
    ///
    /// - Parameter markerArray: model array
    private func setMarkerOnMap(markerArray:[MapInfoWindowModel]) {
        if markerArray.count > 0 {
            let camera = GMSCameraPosition.camera(withLatitude: markerArray[0].latitude, longitude: markerArray[0].longitude, zoom: 14)
            mapView.camera = camera
            for spot in markerArray {
                let marker = GMSMarker()
                marker.appearAnimation = .pop
                marker.position = CLLocationCoordinate2D(latitude: spot.latitude , longitude: spot.longitude)
                marker.map = self.mapView
                // *IMPORTANT* Assign all the spots data to the marker's userData property
                marker.userData = spot
            }
        }
    }
    
    // MARK: - Custom Method
    private func initializeView() {
        self.title = PageTitleStrings.report.localized
        self.reportTableView.estimatedRowHeight = 300.0
        self.reportTableView.rowHeight = UITableView.automaticDimension
        self.reportTableView.tableFooterView = UIView()
        let reportTableViewCell = UINib(nibName: Constants.CellIdentifier.reportTableViewCell, bundle: nil)
        self.reportTableView.register(reportTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.reportTableViewCell)
        self.reportTableView.reloadData()
    }
    private func setupViewType() {
        if reportType == .list {
            // Appearing list view
            self.mapView.isHidden = true
            self.clearAllMarkers()
            self.reportTableView.isHidden = false
            self.reportTableView.reloadData()
        } else {
            // Appearing map view
            self.reportTableView.isHidden = true
            self.mapView.isHidden = false
            loadMarkers()
        }
    }
    
   private func clearAllMarkers()  {
        self.mapView.clear()
        self.customInfoWindow?.removeFromSuperview()
    }
    
    private func setupRightBarButton()  {
        let shareImage    = UIImage(named: "share")!
        let mapImage    = UIImage(named: "map")!
        let filterImage  = UIImage(named: "filter")!
        let listImage    = UIImage(named: "list")!
        mapButton   = UIBarButtonItem(image: mapImage,  style: .plain, target: self, action: #selector(didTapMapButton))
        listButton   = UIBarButtonItem(image: listImage,  style: .plain, target: self, action: #selector(didTapListButton))
        filterButton = UIBarButtonItem(image: filterImage,  style: .plain, target: self, action:#selector(didTapFilterButton))
        shareButton = UIBarButtonItem(image: shareImage,  style: .plain, target: self, action:#selector(didTapShareButton))
        navigationItem.rightBarButtonItems = [filterButton,mapButton,shareButton]
    }
    @objc func didTapMapButton(){
        navigationItem.rightBarButtonItems = [filterButton,listButton,shareButton]
        reportType = .map
        setupViewType()
    }
    
    @objc func didTapListButton(){
        navigationItem.rightBarButtonItems = [filterButton,mapButton,shareButton]
        reportType = .list
        setupViewType()
    }
    
    @objc func didTapShareButton(){
        
    }
    
    @objc func didTapFilterButton(){
        
    }
    
    private func setSegmentControlTextAppearance () {
        let normalAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor:  UIColor.color(withHexCode: "95999c"),
            NSAttributedString.Key.font: UIFont(name: Font.FontName.robotoMedium.rawValue, size: 14)!
        ]
        let selectedAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.color(withHexCode: "ED1C24"),
            NSAttributedString.Key.font: UIFont(name: Font.FontName.robotoMedium.rawValue, size: 14)!
        ]
        segmentControl.setTitleTextAttributes(normalAttributes as? [NSAttributedString.Key : Any], for: .normal)
        segmentControl.setTitleTextAttributes(selectedAttributes as? [NSAttributedString.Key : Any], for: .selected)
        
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.5, animations: {
                self.selectedSegmentLineLeading.constant = 0
            })
        default:
            UIView.animate(withDuration: 0.5, animations: {
                self.selectedSegmentLineLeading.constant = self.segmentControl.frame.size.width / 2
            })
        }
        if reportType == .list {
            reportTableView.reloadData()
        } else {
            self.clearAllMarkers()
            self.loadMarkers()
        }
    }
    
    
}


extension ReportViewController: OpenDetailVcDelegate,GMSMapViewDelegate,MapMarkerDelegate {
    
    func didTapDetailButton(spotData: MapInfoWindowModel?) {
        self.pushToReportDetailViewController(spotData: spotData)
    }
    func openDetailVcForRow(row: Int) {
        if segmentControl.selectedSegmentIndex == 0 {
            self.pushToReportDetailViewController(spotData:  mapInfo.filter({$0.typeOfTests == TestsType.onMyINKcryptIDs})[row])
        } else {
            self.pushToReportDetailViewController(spotData:  mapInfo.filter({$0.typeOfTests == TestsType.iHavePerformed})[row])
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        var markerData : MapInfoWindowModel?
        if let data = marker.userData! as? MapInfoWindowModel {
            markerData = data
        }
        tappedMarker = marker
        customInfoWindow?.removeFromSuperview()
        customInfoWindow = loadNiB()
        //get position of tapped marker
        guard let position = tappedMarker?.position else {
            print("locationMarker is nil")
            return false
        }
        //move marker at the bottom of the screen when marker tapped
        mapView.animate(toLocation: position)
        var point = mapView.projection.point(for: position)
        point.y -= 200
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
        
        // Pass the spot data to the info window, and set its delegate to self
        customInfoWindow?.spotData = markerData
        customInfoWindow?.delegate = self
        customInfoWindow?.addShadow(offset: CGSize.zero, color: UIColor.black, radius: 6.0, opacity: 0.41)
        customInfoWindow?.layer.cornerRadius = 6
        
        customInfoWindow?.bioMarkerId.text = markerData?.bioMarkerID
        customInfoWindow?.itemLabel.text = markerData?.itemLabel
        customInfoWindow?.descriptionLabel.text = markerData?.description
        customInfoWindow?.resultLabel.text = markerData?.result
        customInfoWindow?.dateLabel.text = markerData?.date
        customInfoWindow?.timeLabel.text = markerData?.time
        customInfoWindow?.statusLabel.text = markerData?.status
        
        customInfoWindow?.center = mapView.projection.point(for: position)
        customInfoWindow?.center.y -= 215
        self.mapView.addSubview(customInfoWindow!)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        customInfoWindow?.removeFromSuperview()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let position = tappedMarker?.position
        customInfoWindow?.center = mapView.projection.point(for: position!)
        customInfoWindow?.center.y -= 215
    }
    
}

extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}


