//
//  ReportViewController+TableExtension.swift
//  INKcrypt
//
//  Created by Asif on 11/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

import Foundation

extension ReportViewController: UITableViewDataSource,UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return mapInfo.filter({$0.typeOfTests == TestsType.onMyINKcryptIDs}).count
        } else {
            return mapInfo.filter({$0.typeOfTests == TestsType.iHavePerformed}).count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.reportTableViewCell) as? ReportTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        cell.delegate = self
        if segmentControl.selectedSegmentIndex == 0 {
            cell.configureReportCell(model: mapInfo.filter({$0.typeOfTests == TestsType.onMyINKcryptIDs})[indexPath.row])
        } else {
            cell.configureReportCell(model: mapInfo.filter({$0.typeOfTests == TestsType.iHavePerformed})[indexPath.row])

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
