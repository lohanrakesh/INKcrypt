//
//  ProfileViewController+TableView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension ProfileViewController:UITableViewDataSource,UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.profileTableViewCell) as? ProfileTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            if indexPath.row == ProfilePersonalInfo.phoneNumber.rawValue {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: KPhoneNumberTableViewCellNibName) as? PhoneNumberTableViewCell else
                {return UITableViewCell() }
                cell.configurePhoneNumberTableViewCell()
                return cell
            } else {
            cell.configurePersonalInformationCell(indexPath: indexPath, personalInfo: personalInfo[indexPath.row])
            }
        } else {
            if indexPath.row == ProfileCompanyInfo.city.rawValue {
                  guard let cell = tableView.dequeueReusableCell(withIdentifier: KCityTableViewCellNibName) as? CityTableViewCell else
                  {return UITableViewCell() }
                cell.configureCityTableViewCell()
                return cell
            } else {
            cell.configureCompanyInformationCell(indexPath: indexPath, companyInfo: companyInfo[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
