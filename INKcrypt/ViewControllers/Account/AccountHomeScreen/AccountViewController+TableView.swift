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
        if let user = LoginDetails.getUser() {
            if user.userID > 0 {
                return true
            } else {
                return false
            }
        }
        return false
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
        return dataSourceArray.count
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
        let value = dataSourceArray[indexPath.row].rawValue
        switch value {
        case AccountInfo.myProfile.rawValue:
            pushToProfileViewController()
        case AccountInfo.orderHistory.rawValue:
            pushToOrderViewController()
        case AccountInfo.savedCard.rawValue:
            pushToSavedCardViewController()
        case AccountInfo.settings.rawValue:
            pushToSettingsViewController()
        case AccountInfo.address.rawValue:
            pushToAddressViewController()
        case AccountInfo.contactAndSupport.rawValue:
            pushToContactSupportViewController()
        case AccountInfo.about.rawValue:
            pushToAboutViewController(actionType:.about)
        case AccountInfo.changePassword.rawValue:
            pushToChangePasswordViewController()
        case AccountInfo.termsAndConditions.rawValue, AccountInfo.logout.rawValue, AccountInfo.report.rawValue, AccountInfo.myBiomarkersCodes.rawValue:
            handleSelectionState(value : value)
            
        default:
            return
        }
    }
    
    func handleSelectionState(value : Int) {
         switch value {
         case AccountInfo.termsAndConditions.rawValue:
            pushToAboutViewController(actionType: .termAndCondition)
         case AccountInfo.logout.rawValue:
            signOutAction()
         case AccountInfo.report.rawValue:
            pushToReportViewController()
         case AccountInfo.myBiomarkersCodes.rawValue:
            pushToMyBioMarkersCodesViewController()
         default:
            return
        }
    }
    
    func signOutAction() {
        let alertController = UIAlertController(title: "Alert",
                                                message: "Are you sure you want to logout?",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
                                        alertController.dismiss(animated: true, completion: nil)
                                        self.callLogoutAPI()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { _ in
                                            alertController.dismiss(animated: true, completion: nil)
                                            
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
