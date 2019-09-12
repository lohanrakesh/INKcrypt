//
//  MyBioMarkersViewController+TableViewExtension.swift
//  INKcrypt
//
//  Created by Asif on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension MyBiomarkersViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayOfBioMarkersCodes.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 38
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: KProfileTableHeaderViewNibName) as? ProfileHeaderView else {return UIView() }
        profileHeaderView.infoLabel.text = "BIOMARKER LIST"
      return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.myBiomarkersCodesTableViewCell) as? MyBiomarkersCodesTableViewCell
            else {return UITableViewCell() }
        cell.viewDetailButton.tag =  indexPath.row
        cell.configureBioMarkersCodesCell(model: arrayOfBioMarkersCodes[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        }
    
}
