//
//  TestResultViewController+TableExtension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 22/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension TestResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.testType == .success {
            switch indexPath.row {
                
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.testSuccessTableViewCell, for: indexPath) as? TestSuccessTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.testItemReferenceTableViewCell, for: indexPath) as? TestItemReferenceTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                return cell
                
            default:
                return UITableViewCell()
            }
        }else {
            
            switch indexPath.row {
                
            case 0:
                return testFailTableViewCell(cellForRowAt: indexPath)
                
            case 1:
                return self.testFailReferenceTableViewCell(cellForRowAt: indexPath)
                
            default:
                return UITableViewCell()
            }
        }
    }
    
    //MARK:- Cell
    func testFailReferenceTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.testFailReferenceTableViewCell, for: indexPath) as? TestFailReferenceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func testFailTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.testFailTableViewCell, for: indexPath) as? TestFailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
}
