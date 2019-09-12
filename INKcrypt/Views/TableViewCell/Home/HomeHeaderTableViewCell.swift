//
//  HomeHeaderTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 25/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class HomeHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let homeHeaderQrCollectionViewCell = UINib(nibName: Constants.CellIdentifier.homeHeaderQrCollectionViewCell, bundle: nil)
        self.collectionView.register(homeHeaderQrCollectionViewCell, forCellWithReuseIdentifier: Constants.CellIdentifier.homeHeaderQrCollectionViewCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeHeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.homeHeaderQrCollectionViewCell, for: indexPath) as? HomeHeaderQrCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewC = self.viewContainingController(), let tab = viewC.tabBarController {
            tab.selectedIndex = 1
//            if let nav = tab.viewControllers?[1] as? UINavigationController, let authVC = nav.topViewController as? AuthenticationViewController {
//            authVC.pushToPatternDetailViewController(nil, qrId: "LAU6I-6IXPZ", qrImage: nil)
//            }
        }
    }

}
