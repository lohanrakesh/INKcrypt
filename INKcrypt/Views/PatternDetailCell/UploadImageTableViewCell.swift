//
//  UploadImageTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 19/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class UploadImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    
    var imageArray = [UIImage]()
    var picker = UIImagePickerController()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.isHidden = true
        let uploadImageCollectionViewCell = UINib(nibName: Constants.CellIdentifier.uploadImageCollectionViewCell, bundle: nil)
        self.collectionView.register(uploadImageCollectionViewCell, forCellWithReuseIdentifier: Constants.CellIdentifier.uploadImageCollectionViewCell)
       // self.collectionView.register(uploadImageCollectionViewCell, forCellReuseIdentifier: Constants.CellIdentifier.uploadImageCollectionViewCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func deleteButtonClicked(_ sender: UIButton){
        debugPrint("Delete button clicked:- \(sender.tag)")
        if self.imageArray.count == 1{
            self.imageArray.removeAll()
            self.collectionView.reloadData()
            self.collectionView.isHidden = true
        }else{
            self.imageArray.remove(at: sender.tag)
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- Action
    @IBAction func imageUploadButtonClicked(sender: UIButton){
        
        picker.delegate = self
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        if let viewC = self.viewContainingController() as?  PatternDetailViewController{
            viewC.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func leftArrowButtonClicked(sender: UIButton){
        let visibleItems = self.collectionView.indexPathsForVisibleItems
        
        if let currentItem = visibleItems.first, currentItem.item != 0 {
            let nextItem = IndexPath(item: currentItem.item - 1, section: 0)
            // This part here
            if nextItem.item < self.imageArray.count {
                self.collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    @IBAction func rightArrowButtonClicked(sender: UIButton){
//        let cellSize = self.collectionView.frame.size
//
//        //get current content Offset of the Collection view
//        let contentOffset = collectionView.contentOffset
//
//        if collectionView.contentSize.width <= collectionView.contentOffset.x + cellSize.width
//        {
//            let r = CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
//            collectionView.scrollRectToVisible(r, animated: true)
//
//        } else {
//            let r = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
//            collectionView.scrollRectToVisible(r, animated: true);
//        }
        
        let visibleItems = self.collectionView.indexPathsForVisibleItems
        if let currentItem = visibleItems.first {
        let nextItem = IndexPath(item: currentItem.item + 1, section: 0)
        // This part here
        if nextItem.item < self.imageArray.count {
            self.collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
            
        }
        }
    }
    
}

extension UploadImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.uploadImageCollectionViewCell, for: indexPath) as? UploadImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector( UploadImageTableViewCell.deleteButtonClicked(_:)), for: .touchUpInside)
        
        if imageArray.count > 0 {
            cell.uploadImageView.image = self.imageArray[indexPath.item]
        }
        
        return cell
    }
}


extension UploadImageTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        self.imageArray.append(image)
        if imageArray.count == 1 {
            self.collectionView.isHidden = false
        }
         self.collectionView.reloadData()
        }
    }
}
