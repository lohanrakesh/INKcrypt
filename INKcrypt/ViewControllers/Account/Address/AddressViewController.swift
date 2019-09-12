//
//  AddressViewController.swift
//  INKcrypt
//
//  Created by Asif on 27/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

struct AddressListModel {
    var defaultAddressArray : [AddressInfoModel] = []
    var otherAddressArray : [AddressInfoModel] = []
}

class AddressViewController: ViewController {
    
    var addressListModel = AddressListModel()
    
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var crossButton: UIButton!
    
    var selectedAddress: ((AddressInfoModel) -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchAddressList()
    }
    
    // MARK: - Custom Method
    func initializeView(){
        setNavBarTitle()
        registerTableCell()
        
        if selectedAddress != nil {
            self.crossButton.isHidden = false
        }
    }
    
    private func setNavBarTitle() {
        self.title = PageTitleStrings.addressBook.localized
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        addressTableView.tableHeaderView = UIView(frame: frame)
    } 
    
    private func registerTableCell() {
        addressTableView.tableFooterView = UIView()
        let addressTableViewCell = UINib(nibName: Constants.CellIdentifier.addressTableViewCell, bundle: nil)
        self.addressTableView.register(addressTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.addressTableViewCell)
        let addressTableHeaderViewNibName = UINib(nibName: KProfileTableHeaderViewNibName, bundle: nil)
        self.addressTableView.register(addressTableHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KProfileTableHeaderViewNibName)
        addressTableView.rowHeight = UITableView.automaticDimension
        addressTableView.estimatedRowHeight = 300
    }
    
    @IBAction func addNewAddressButtonPressed(_ sender: UIButton) {
        if addressListModel.defaultAddressArray.isEmpty {
            preformAddressAction(addressMode: .add, addressInfo: nil, addressType: .defaultAddress)
        } else {
            preformAddressAction(addressMode: .add, addressInfo: nil, addressType: .otherAddress)
        }
    }
    
    private func preformAddressAction(addressMode : AddressMode, addressInfo : AddressInfoModel?, addressType : AddressType) {
        guard let editAddressViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.editAddressViewController) as? EditAddressViewController else {
            return
        }
        editAddressViewController.updatedAddressInfo(addressInfo: addressInfo, addressMode: addressMode, addressType: addressType) { (addressInfo, addressMode) in
            if addressMode == .add {
            } else {
            }
            DispatchQueue.main.async {
                self.addressTableView.reloadData()
            }
        }
        self.navigationController?.pushViewController(editAddressViewController, animated: true)
    }
    
    func editButtonPressedForIndexPath(indexPath : IndexPath) {
        if indexPath.section == 0 {
            let model = self.addressListModel.defaultAddressArray[indexPath.row]
            preformAddressAction(addressMode: .edit, addressInfo: model, addressType: .defaultAddress)
        } else {
             let model = self.addressListModel.otherAddressArray[indexPath.row]
            preformAddressAction(addressMode: .edit, addressInfo: model, addressType: .otherAddress)
        }
    }
    
    func deleteButtonPressedForIndexPath(indexPath : IndexPath) {
        
        let alertController = UIAlertController(title: "Alert",
                                                message: "Are you sure you want to delete?",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
                                        alertController.dismiss(animated: true, completion: nil)
                                        if indexPath.section == 0 {
                                            self.callDeleteAddressAPI(addressID: self.addressListModel.defaultAddressArray[indexPath.row].addressID)
                                        } else {
                                            self.callDeleteAddressAPI(addressID: self.addressListModel.otherAddressArray[indexPath.row].addressID)
                                        }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { _ in
                                            alertController.dismiss(animated: true, completion: nil)
                                            
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    
    }
    
    func updateAddressModel(addressArray : [AddressInfoModel]) {
         self.addressListModel.defaultAddressArray.removeAll()
        self.addressListModel.otherAddressArray.removeAll()
        for address in addressArray {
            if address.isDefault {
                self.addressListModel.defaultAddressArray.append(address)
            } else {
                self.addressListModel.otherAddressArray.append(address)
            }
    }
        DispatchQueue.main.async {
            self.addressTableView.reloadData()
        }
    }
    
    // MARK: - WebService
    func fetchAddressList() {
        if let user = LoginDetails.getUser() {
            router.serviceForEndPoint(apiType: .getAddressList(model: [Constants.APIParameterKey.userID:String(user.userID)]), decodingType: [AddressInfoModel].self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, let model):
                    if let response = responseData {
                        if response.success {
                            if let addressModel = model {
                                self?.updateAddressModel(addressArray: addressModel)
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "Save address API failed")
                        }
                    }
                    
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    func callDeleteAddressAPI(addressID : Int) {
        if let user = LoginDetails.getUser() {
            router.serviceForEndPoint(apiType: .removeAddressList(model: [Constants.APIParameterKey.userID:String(user.userID),Constants.APIParameterKey.addressId:addressID]), decodingType: [AddressInfoModel].self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, let model):
                    if let response = responseData {
                        if response.success {
                            if let addressModel = model {
                                self?.updateAddressModel(addressArray: addressModel)
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "Delete address API failed")
                        }
                    }
                    
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:- Action
    @IBAction func crossButtonClicked(sender: UIButton){
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
