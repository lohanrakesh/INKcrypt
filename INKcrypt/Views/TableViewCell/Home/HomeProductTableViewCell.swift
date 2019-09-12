//
//  HomeProductTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 25/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class HomeProductTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var productList: [HomeProduct]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let homeProductCollectionViewCell = UINib(nibName: Constants.CellIdentifier.homeProductCollectionViewCell, bundle: nil)
        self.collectionView.register(homeProductCollectionViewCell, forCellWithReuseIdentifier: Constants.CellIdentifier.homeProductCollectionViewCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension HomeProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.homeProductCollectionViewCell, for: indexPath) as? HomeProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let model = self.productList?[indexPath.item] {
        cell.productImageView.sd_setImage(with: URL(string: model.imagePath), placeholderImage: UIImage(named: Constants.Images.bannerPlaceholder))
        cell.productNameLabel.text = model.productName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 154.0, height: 203.0)
    }
    
    
}
