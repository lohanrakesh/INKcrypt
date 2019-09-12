//
//  SavedCardViewController+TableView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/26/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
extension SavedCardViewController:UITableViewDataSource,UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardInfoArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.savedCardTableViewCell) as? SavedCardTableViewCell else {return UITableViewCell() }
        cell.selectionStyle = .none
       cell.configureSavedCardTableViewCell(cardInfo: self.cardInfoArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
