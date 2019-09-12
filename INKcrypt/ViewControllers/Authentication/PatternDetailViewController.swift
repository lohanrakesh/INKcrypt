//
//  PatternDetailViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 21/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class PatternDetailViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var qrCodeImage : UIImage? = nil
    var qrId : String?
    var imagePattern: ImagePatternResponse?
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.tableView.estimatedRowHeight = 200.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        
        let qrProductTableViewCell = UINib(nibName: Constants.CellIdentifier.qrCodeTableViewCell, bundle: nil)
        self.tableView.register(qrProductTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.qrCodeTableViewCell)
        
        let patternImageTableViewCell = UINib(nibName: Constants.CellIdentifier.patternImageTableViewCell, bundle: nil)
        self.tableView.register(patternImageTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.patternImageTableViewCell)
        
        let uploadImageTableViewCell = UINib(nibName: Constants.CellIdentifier.uploadImageTableViewCell, bundle: nil)
        self.tableView.register(uploadImageTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.uploadImageTableViewCell)
        
    }
    
    func createQRFromString() -> CIImage? {
        if let str = qrId {
            let stringData = str.data(using: String.Encoding.utf8)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(stringData, forKey: "inputMessage")
            
            filter?.setValue("H", forKey: "inputCorrectionLevel")
            
            return filter?.outputImage
        }
        return nil
    }
    
    
    // MARK: - Action
    @IBAction func submitButtonClicked(_ sender: UIButton){
        self.pushToTestResultViewController()
    }
    
}


extension PatternDetailViewController:UITableViewDataSource,UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 3
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.qrCodeTableViewCell) as? QrCodeTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            cell.qrId.text = self.qrId
            return cell
            
        case 1:
            
            return self.tableViewImagePatternCell(cellForRowAt: indexPath)
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.uploadImageTableViewCell) as? UploadImageTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableViewImagePatternCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.patternImageTableViewCell) as? PatternImageTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        if let patternArrary = imagePattern?.result?.components(separatedBy: ","){
            for result in patternArrary{
                switch result.uppercased() {
                case "0":
                    cell.button0.isSelected = true
                case "1":
                    cell.button1.isSelected = true
                case "2":
                    cell.button2.isSelected = true
                case "3":
                    cell.button3.isSelected = true
                case "4":
                    cell.button4.isSelected = true
                case "5":
                    cell.button5.isSelected = true
                default:
                    self.setImagePatternCell(value: result.uppercased(), cell: cell)
                }
            }
        }
        
        cell.qrId.text = self.qrId
        cell.qrCodeImageView.image = self.qrCodeImage
        
        return cell
    }
    
    func setImagePatternCell(value: String, cell: PatternImageTableViewCell){
        switch value {
        case "6":
            cell.button6.isSelected = true
        case "7":
            cell.button7.isSelected = true
        case "8":
            cell.button8.isSelected = true
        case "9":
            cell.button9.isSelected = true
        case "A":
            cell.buttonA.isSelected = true
        case "B":
            cell.buttonB.isSelected = true
        default:
            debugPrint(value)
        }
    }
}
