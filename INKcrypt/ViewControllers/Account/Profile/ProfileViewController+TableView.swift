//
//  ProfileViewController+TableView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension ProfileViewController:UITableViewDataSource,UITableViewDelegate,UpdatedProfileInfoDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 7
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 90
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: KProfileTableHeaderViewNibName) as? ProfileHeaderView else {return UIView() }
        profileHeaderView.configureProfileHeaderView(section: section)
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            if let view = Bundle.main.loadNibNamed(KProfileTableFooterViewNibName, owner: self, options: nil)?.first as? ProfileTableFooterView {
                return view
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = Bundle.main.loadNibNamed(Constants.CellIdentifier.profileTableViewCell, owner: nil, options: .none)?.first as? ProfileTableViewCell //tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.profileTableViewCell) as? ProfileTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            if indexPath.row == ProfilePersonalInfo.phoneNumber.rawValue {
                return getPhoneNumberTableViewCell(tableView: tableView, cellForRowAt: indexPath)
            } else {
                cell.configurePersonalInformationCell(indexPath: indexPath, personalInfo: personalInfo[indexPath.row], profileModel: profileModel)
            }
        } else {
            if indexPath.row == ProfileCompanyInfo.city.rawValue {
                return getCityTableViewCell(tableView: tableView, cellForRowAt: indexPath)
            } else if indexPath.row == ProfileCompanyInfo.phoneNumber.rawValue {
                return getPhoneNumberTableViewCell(tableView: tableView, cellForRowAt: indexPath)
            } else if indexPath.row == ProfileCompanyInfo.country.rawValue {
                return getCountryTableViewCell(tableView: tableView, cellForRowAt: indexPath)
            } else {
                cell.configureCompanyInformationCell(indexPath: indexPath, companyInfo: companyInfo[indexPath.row], profileModel: profileModel)
            }
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getPhoneNumberTableViewCell(tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KPhoneNumberTableViewCellNibName) as? PhoneNumberTableViewCell else
        {return UITableViewCell() }
        cell.delegate = self
        cell.configurePhoneNumberTableViewCell(model: profileModel, indexPath: indexPath,countryArray: self.countryCodeArray)
        return cell
    }
    
    func getCityTableViewCell(tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KCityTableViewCellNibName) as? CityTableViewCell else
        {return UITableViewCell() }
        cell.configureCityTableViewCell(profileModel: profileModel, indexPath: indexPath, arrayOfStates: stateArray)
        cell.delegate = self
        return cell
    }
    
    func getCountryTableViewCell(tableView : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KCountryTableViewCellNibName) as? CountryTableViewCell else
        {return UITableViewCell() }
        cell.configureCountryTableViewCell(profileModel: profileModel, indexPath: indexPath, arrayOfCountry: countryArray)
        cell.delegate = self
        cell.countryListDelegate = self
        return cell
    }
    
    //MARK:- UpdatedProfileInfoDelegate
    
    func updatedInfoForIndexPath(indexPath : IndexPath, info : String, tagValue : Int) {
        if profileModel == nil {profileModel = Profile()}
        switch indexPath.section {
        case 0:
            updatePersonalInfoForIndexPath(indexPath: indexPath, info: info, tagValue: tagValue)
            
        case 1:
            updateCompanyInfoForIndexPath(indexPath: indexPath, info: info, tagValue: tagValue)
            
        default:
            break
        }
        tableView.reloadData()
    }
    
    func updatePersonalInfoForIndexPath(indexPath : IndexPath, info : String, tagValue : Int) {
        switch indexPath.row {
        case ProfilePersonalInfo.firstName.rawValue:
            profileModel?.fisrtName = info
            
        case ProfilePersonalInfo.lastName.rawValue:
            profileModel?.lastName = info
            
        case ProfilePersonalInfo.email.rawValue:
            profileModel?.eMail = info
            
        case ProfilePersonalInfo.phoneNumber.rawValue:
            if tagValue == KPhoneNumberTag {
                profileModel?.userMobileNo = info
                
            } else if tagValue == KContryCodeTag {
                profileModel?.userCountryCode = info
            }
        default:
            return
        }
        
    }
    
    func updateCompanyInfoForIndexPath(indexPath : IndexPath, info : String, tagValue : Int) {
        switch indexPath.row {
        case ProfileCompanyInfo.name.rawValue:
            profileModel?.companyName = info
        case ProfileCompanyInfo.phoneNumber.rawValue:
            updateCompanyPhoneNumber(tagValue: tagValue, info: info)
        case ProfileCompanyInfo.addressLine1.rawValue:
            profileModel?.address1 = info
        case ProfileCompanyInfo.addressLine2.rawValue:
            profileModel?.address2 = info
        case ProfileCompanyInfo.city.rawValue:
            if tagValue == KCitiTag {
                profileModel?.companyCityName = info
            } else {
                profileModel?.companystateName = info
            }
        case ProfileCompanyInfo.country.rawValue:
            profileModel?.companycountryName = info
        case ProfileCompanyInfo.zipCode.rawValue:
            profileModel?.companyZipcode = info
        default:
            return
        }
    }
    
    func updateCompanyPhoneNumber(tagValue : Int,info : String) {
        if tagValue == KCompanyPhoneNumberTag {
            profileModel?.companyPhoneNo = info
        } else if tagValue == KCompanyContryCodeTag {
            profileModel?.companyCountryCode = info
        }
    }
}
