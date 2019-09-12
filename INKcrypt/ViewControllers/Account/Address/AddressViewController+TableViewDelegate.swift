//
//  AddressViewController+TableViewDelegate.swift
//  INKcrypt
//
//  Created by Asif on 27/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension AddressViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int  {
//        var sectionCount = 0
//        if !addressListModel.defaultAddressArray.isEmpty {
//           sectionCount = sectionCount + 1
//        }
//
//        if !addressListModel.otherAddressArray.isEmpty {
//             sectionCount = sectionCount + 1
//        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           return addressListModel.defaultAddressArray.count
        } else {
             return addressListModel.otherAddressArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if !addressListModel.defaultAddressArray.isEmpty {
                return 38
            } else {
                return 0
            }
        } else {
            if !addressListModel.otherAddressArray.isEmpty {
                return 38
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if !addressListModel.defaultAddressArray.isEmpty {
                return  UITableView.automaticDimension
            } else {
                return 0
            }
        } else {
            if !addressListModel.otherAddressArray.isEmpty {
                return  UITableView.automaticDimension
            } else {
                return 0
            }
        }
       // return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: KProfileTableHeaderViewNibName) as? ProfileHeaderView else {return UIView() }
        profileHeaderView.configureAddressHeaderView(section: section)
       
        if section == 0 {
            if !addressListModel.defaultAddressArray.isEmpty {
                return profileHeaderView
            } else {
                return nil
            }
        } else {
            if !addressListModel.otherAddressArray.isEmpty {
                return profileHeaderView
            } else {
                return nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.addressTableViewCell) as? AddressTableViewCell
            else {return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.configureAddressCell(addressInfo: addressListModel.defaultAddressArray[indexPath.row], indexPath: indexPath)
        } else {  
            cell.configureAddressCell(addressInfo: addressListModel.otherAddressArray[indexPath.row], indexPath: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedAddress != nil {
            if indexPath.section == 0 {
               selectedAddress(addressListModel.defaultAddressArray[indexPath.row])
            }else {
                selectedAddress(addressListModel.otherAddressArray[indexPath.row])
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
