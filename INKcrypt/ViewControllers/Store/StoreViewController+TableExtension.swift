//
//  StoreViewController+TableExtension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return self.productArray.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray[section].productDataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = Bundle.main.loadNibNamed(String(describing: StoreTableViewSection.self), owner: nil, options: nil)![0] as? StoreTableViewSection else {
            return nil
        }
        header.sectionTitleLabel.text = self.productArray[section].productCategoryName ?? ""
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.productArray[indexPath.section]
        
        switch model.productCategoryID {
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.newExistingStoreTableViewCell) as? NewExistingStoreTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            cell.model = model.productDataList?[indexPath.row]
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.codeStoreTableViewCell) as? CodeStoreTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            cell.model = model.productDataList?[indexPath.row]
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.simpleStoreTableViewCell) as? SimpleStoreTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            cell.model = model.productDataList?[indexPath.row]
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
