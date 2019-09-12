//
//  SavedCardViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/26/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

struct CardInfo {
    
    var cardNumber : Double
    var cardValidity : String
    var cvv : String
    var name : String
    
    init(cardNumber: Double, cardValidity:String,cvv: String,name : String) {
        self.cardNumber = cardNumber
        self.cardValidity = cardValidity
        self.cvv = cvv
        self.name = name
    }
}

class SavedCardViewController : ViewController {
 @IBOutlet weak var tableView: UITableView!
    var cardInfoArray : [CardInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        let savedCardTableViewCell = UINib(nibName: Constants.CellIdentifier.savedCardTableViewCell, bundle: nil)
        self.tableView.register(savedCardTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.savedCardTableViewCell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewCardButtonPressed(_ sender: Any) {
        preformCardAction(cardMode: .add, cardInfo: nil)
       
    }
    
    func preformCardAction(cardMode : CardMode, cardInfo : CardInfo?) {
        guard let cardViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.cardViewController) as? CardViewController else {
            return
        }
        cardViewController.updatedCardInfo(cartInfo: cardInfo, cardMode: cardMode) { (cardInfo, cardMode) in
            if cardMode == .add {
                self.cardInfoArray.append(cardInfo)
               
            } else {
                if let row = self.cardInfoArray.firstIndex(where: {$0.cardNumber == cardInfo.cardNumber}) {
                    self.cardInfoArray[row] = cardInfo
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.navigationController?.pushViewController(cardViewController, animated: true)
    }
    
}
