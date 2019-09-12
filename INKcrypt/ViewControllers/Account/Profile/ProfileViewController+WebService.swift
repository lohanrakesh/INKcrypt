//
//  ProfileViewController+WebService.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/13/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension ProfileViewController: fetchCoutryAndStateListDelegate {
    
    func clearAllFieldRelatedToCountry() {
        profileModel?.companyCityName = ""
        profileModel?.companystateName = ""
        profileModel?.companyZipcode = ""
        DispatchQueue.main.async {
            self.tableView.reloadSections([1], with: .none)
        }
    }
    
    func fetchStateListAPI(selectedCountryID: String) {
        callGetStateListAPI(countryID: Int(selectedCountryID) ?? 0)
    }
    
    func fetchCountryListAPI() {
        callGetCountryListAPI()
    }
    
    
    func callMyProfileAPI() {
        if let user = LoginDetails.getUser() {
            add(loadingViewController)
            
            router.serviceForEndPoint(apiType: .profile(model: [Constants.APIParameterKey.userID:user.userID]), decodingType: Profile.self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                    switch result {
                    case .success(let responseData, let model):
                        if let response = responseData {
                            if response.success {
                                self?.handleProfileResponse(profile: model)
                            } else {
                                self?.showToastOnTop(message: response.message ?? "Profile API failed")
                            }
                        }
                    case .failure(let error):
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func callSaveProfileAPI() {
        if checkValidation() {
            add(loadingViewController)
            router.serviceForEndPoint(apiType: .updateProfile(model: self.updateModel), decodingType: Profile.self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                    switch result {
                    case .success(let responseData, _):
                        if let response = responseData {
                            if let message = response.message {
                                self?.showToastOnTop(message: message)
                            }
                            if response.success {
                                self?.popViewController()
                            }
                        }
                        
                        
                    case .failure(let error):
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //MARK:- API
    func getCountryCodeApiCall(){
        add(loadingViewController)
        self.router.serviceForEndPoint(apiType: .countryCode, decodingType: [CountryCode].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {return}
                if  response.success {
                    if let objects = model {
                        self?.countryCodeArray.removeAll()
                        for object in objects {
                            self?.countryCodeArray.append(object)
                        }
                        DispatchQueue.main.async {
                            self?.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
                        }
                    }
                } else {
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
    
    
    func handleProfileResponse(profile : Profile?) {
        guard let model = profile else {
            self.showToastOnTop(message: "User Profile data missing")
            return
        }
        self.profileModel = model
        configureUpdateModel()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
    
    func callGetCountryListAPI() {
        if let user = LoginDetails.getUser() {
            router.serviceForEndPoint(apiType: .getCountryList(model: [Constants.APIParameterKey.userID:String(user.userID)]), decodingType: [Country].self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, let model):
                    if let response = responseData {
                        if response.success {
                            if let countryArray = model {
                                self?.countryArray.removeAll()
                                self?.countryArray.append(contentsOf: countryArray)
                                DispatchQueue.main.async {
                                    self?.tableView.reloadRows(at: [IndexPath(row: 4, section: 1)], with: .none)
                                }
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "Country API failed")
                        }
                    }
                    
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    func callGetStateListAPI(countryID : Int) {
        router.serviceForEndPoint(apiType: .getStateList(countryID: countryID), decodingType: [Country].self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            switch result {
            case .success(let responseData, let model):
                if let response = responseData {
                    if response.success {
                        if let array = model {
                            self?.stateArray.removeAll()
                            self?.stateArray.append(contentsOf: array)
                        }
                    } else {
                        self?.showToastOnTop(message: response.message ?? "State API failed")
                    }
                }
                
            case .failure(let error):
                self?.showToastOnTop(message: error.localizedDescription)
            }
        }
    }
    
    func fetchStateList() {
        if let str = selectedCountryID, let id = Int(str) {
            callGetStateListAPI(countryID: id)
        }
    }
    
}
