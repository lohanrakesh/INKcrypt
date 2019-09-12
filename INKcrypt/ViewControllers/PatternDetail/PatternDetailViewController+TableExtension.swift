//
//  PatternDetailViewController+TableExtension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 22/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit

extension PatternDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.qrCodeTableViewCell, for: indexPath) as? QrCodeTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            return cell
            
        case 1,2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.patternDetailTableViewCell, for: indexPath) as? PatternDetailTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.patternImageTableViewCell, for: indexPath) as? PatternImageTableViewCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            return cell
                        
        default:
            return UITableViewCell()
        }
    }
    
}
