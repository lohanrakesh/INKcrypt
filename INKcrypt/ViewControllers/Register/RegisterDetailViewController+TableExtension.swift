//
//  RegisterDetailViewController+TableExtension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 26/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension RegisterDetailViewController: UITableViewDataSource,UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 6
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 4:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1, 4, 5:
            return 12.0
        default:
            return 0.0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return self.qrCodeTableViewCell(cellForRowAt: indexPath)
                
            case 1, 2:
                return self.registerDetailTextFieldTableViewCell(cellForRowAt: indexPath)
                
            default:
                return UITableViewCell()
            }
            
        case 1:
            return self.registerDetailCodeTableViewCell(cellForRowAt: indexPath)
            
        case 2:
            return self.registerDetailSubordinateCodeTableViewCell(cellForRowAt: indexPath)
            
        case 3:
            return self.registerDetailBatchCertTableViewCell(cellForRowAt: indexPath)
            
        case 4:
            return self.registerDetailTextFieldTableViewCell(cellForRowAt: indexPath)
            
        case 5:
            return self.registerDetailTextFieldTableViewCell(cellForRowAt: indexPath)
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Cell
    func registerDetailTextFieldTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.registerDetailTextFieldTableViewCell) as? RegisterDetailTextFieldTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func registerUploadImageTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.registerUploadImageTableViewCell) as? RegisterUploadImageTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func registerDetailBatchCertTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.registerDetailBatchCertTableViewCell) as? RegisterDetailBatchCertTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func registerDetailSubordinateCodeTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.registerDetailSubordinateTableViewCell) as? RegisterDetailSubordinateCodeTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func registerDetailCodeTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.registerDetailCodeTableViewCell) as? RegisterDetailCodeTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func qrCodeTableViewCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.qrCodeTableViewCell) as? QrCodeTableViewCell
            else {return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
}

