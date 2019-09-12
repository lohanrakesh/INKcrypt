//
//  AccountViewController+TableView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/22/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension AccountViewController:UITableViewDataSource,UITableViewDelegate {
    func isUserLogin() ->Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isUserLogin() {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: KSignInHeaderViewNibName) as? SignInHeaderView else {return UIView() }
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !isUserLogin() {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isUserLogin() {
            if section == 1 {
                return 0
            } else {
                return dataSourceArray.count
            }
        } else {
            return dataSourceArray.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell else {return UITableViewCell() }
        cell.selectionStyle = .none
        let accountInfo = dataSourceArray[indexPath.row]
        cell.configureAccountTableViewCell(info: accountInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case AccountInfo.myProfile.rawValue:
            pushToProfileViewController()
        case AccountInfo.savedCard.rawValue:
            pushToSavedCardViewController()
        case AccountInfo.settings.rawValue:
            pushToSettingsViewController()
        case AccountInfo.address.rawValue:
            pushToAddressViewController()
        case AccountInfo.contactAndSupport.rawValue:
            pushToChangePasswordViewController()
        case AccountInfo.about.rawValue:
            pushToAboutViewController()
        default:
            return
        }
    }
}
