//
//  HomeViewController+TableExtension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 25/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.homeHeaderTableViewCell) as? HomeHeaderTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.homeProductTableViewCell) as? HomeProductTableViewCell
                else {return UITableViewCell() }
            
            cell.productList = self.homeModel?.productDataList.products
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.homeReportActivityTableViewCell) as? HomeReportActivityTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }

}
