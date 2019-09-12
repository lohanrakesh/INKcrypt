//
//  RegisterUploadImageTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 27/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class RegisterUploadImageTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageArray = [UIImage]()
    var picker = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.pageControl.isHidden = true

        let registerDetailCollectionViewCell = UINib(nibName: Constants.CellIdentifier.registerDetailImageCollectionViewCell, bundle: nil)
        self.collectionView.register(registerDetailCollectionViewCell, forCellWithReuseIdentifier: Constants.CellIdentifier.registerDetailImageCollectionViewCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK:- Action
    @IBAction func imageUploadButtonClicked(sender: UIButton){
        
        picker.delegate = self
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        if let viewC = self.viewContainingController() as?  RegisterDetailViewController {
            viewC.present(picker, animated: true, completion: nil)
        }
    }
}

extension RegisterUploadImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.registerDetailImageCollectionViewCell, for: indexPath) as? RegisterDetailUploadImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if imageArray.count > 0 {
            cell.uploadImageView.image = self.imageArray[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 304.0, height: 304.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width: CGFloat = 304.0
        let horizontalCenter = width / 2
        
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}


extension RegisterUploadImageTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        self.pageControl.isHidden = false
        self.pageControl.numberOfPages = self.imageArray.count
        self.collectionView.reloadData()
        }
    }
}
