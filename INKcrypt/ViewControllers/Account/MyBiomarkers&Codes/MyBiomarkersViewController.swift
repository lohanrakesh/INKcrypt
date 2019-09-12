//
//  MyBiomarkersViewController.swift
//  INKcrypt
//
//  Created by Asif on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

struct BioMarkersCodesModel {
        var bioMarkerId : String?
        var certificateNo : String?
        var type : String?
        var registrar : String?
        var testPart : String?
        var registrationOn : String?
        var expiresOn : String?
        var description :  String?
        var count : String?
        var testerSetting : String?
        var bmi : Bool?
    init(bioMarkerId:String?,certificateNo:String?,type:String?,registrar:String?,testPart:String?,registrationOn:String?,expiresOn:String?,description:String?,count:String?,testerSetting:String?,bmi:Bool?) {
        self.bioMarkerId = bioMarkerId
        self.certificateNo = certificateNo
        self.type = type
        self.registrar = registrar
        self.testPart = testPart
        self.registrationOn = registrationOn
        self.expiresOn = expiresOn
        self.description = description
        self.count = count
        self.testerSetting = testerSetting
        self.bmi = bmi
    }
}

class MyBiomarkersViewController: ViewController {
    //Outlets
    @IBOutlet weak var bioMarkerTableView: UITableView!
    var arrayOfBioMarkersCodes = [BioMarkersCodesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        setupArrayOfMarkersCodes()
        // Do any additional setup after loading the view.
    }
    // MARK: - Custom Method
    private func initializeView() {
        self.title = PageTitleStrings.myBiomarkers.localized
        self.registerTableCell()
    }
    
    private func registerTableCell() {
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        bioMarkerTableView.tableHeaderView = UIView(frame: frame)
        bioMarkerTableView.tableFooterView = UIView()
        let biomarkerTableViewCell = UINib(nibName: Constants.CellIdentifier.myBiomarkersCodesTableViewCell, bundle: nil)
        self.bioMarkerTableView.register(biomarkerTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.myBiomarkersCodesTableViewCell)
        let biomarkerTableHeaderViewNibName = UINib(nibName: KProfileTableHeaderViewNibName, bundle: nil)
        self.bioMarkerTableView.register(biomarkerTableHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KProfileTableHeaderViewNibName)
        bioMarkerTableView.rowHeight = UITableView.automaticDimension
        bioMarkerTableView.estimatedRowHeight = 300
    }

    private func setupArrayOfMarkersCodes() {
        arrayOfBioMarkersCodes = [
            BioMarkersCodesModel(bioMarkerId: "H65JdR2mns2S", certificateNo: "OpJdR2mns875", type: "Type A",registrar : "KV", testPart: "SQ-d-561", registrationOn: "01/03/2018", expiresOn: "01/03/2019", description: "KV Checks Accounts: *1234; *3456", count: "500", testerSetting: "Default", bmi: true),
            BioMarkersCodesModel(bioMarkerId: "GY672346", certificateNo: "Khdadgh7", type: "Type B",registrar : "AB", testPart: "SQ-d-561", registrationOn: "01/03/2018", expiresOn: "01/03/2019", description: "AB Checks Accounts: *1234; *3456", count: "666", testerSetting: "Default", bmi: false),
            BioMarkersCodesModel(bioMarkerId: "YJAH654", certificateNo: "656656+5+", type: "Type C",registrar : "CD", testPart: "SQ-d-561", registrationOn: "01/03/2018", expiresOn: "01/03/2019", description: "CD Checks Accounts: *1234; *3456", count: "323", testerSetting: "Default", bmi: true),
            BioMarkersCodesModel(bioMarkerId: "MNI543W", certificateNo: "78798797", type: "Type D",registrar : "DF", testPart: "SQ-d-561", registrationOn: "01/03/2018", expiresOn: "01/03/2019", description: "DF Checks Accounts: *1234; *3456", count: "100", testerSetting: "Default", bmi: false),
            BioMarkersCodesModel(bioMarkerId: "OPY74564R", certificateNo: "wdsqd242", type: "Type E",registrar : "ER", testPart: "SQ-d-561", registrationOn: "01/03/2018", expiresOn: "01/03/2019", description: "ER Checks Accounts: *1234; *3456", count: "782", testerSetting: "Default", bmi: true)
        ]
        self.bioMarkerTableView.reloadData()
    }
    @IBAction func addBioMarkersButtonAction(_ sender: UIButton) {
        print("Add BioMarkers Button Pressed!")
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

extension MyBiomarkersViewController:BioMarkersCodesDelegate {
    func didTapOnBioMarkersCodesViewDetailsButton(tag: Int) {
        print("row tapped : \(tag)")
    }
    
    
}
