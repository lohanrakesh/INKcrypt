//
//  SettingsViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/27/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

class SettingsViewController : ViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var companyWebsiteTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var pageURLTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var kitURLTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var photoEditIconImageView: UIImageView!

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var failOnlyButton: UIButton!
    @IBOutlet weak var passOnlyButton: UIButton!
    @IBOutlet weak var noneButton: UIButton!
    @IBOutlet weak var saveButton: UILocalizedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callGetUserSettingAPI()
        setNavBarTitle()
        configureButtonInitialState()
    }
    
    private func setNavBarTitle() {
        self.title = PageTitleStrings.setting.localized
    }
    
    func configureButtonInitialState() {
        allButton.isSelected = false
        noneButton.isSelected = false
        failOnlyButton.isSelected = false
        passOnlyButton.isSelected = false
        updateSelectionState()
    }
    
   
    
    // MARK: - UIAction
    @IBAction func photoButtonPressed(_ sender: Any) {
        let prompt = UIAlertController(title: "Choose a Photo",
                                       message: "Please choose a photo.",
                                       preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        func presentCamera(_ _: UIAlertAction) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default,
                                         handler: presentCamera)
        
        func presentLibrary(_ _: UIAlertAction) {
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library",
                                          style: .default,
                                          handler: presentLibrary)
        
        func presentAlbums(_ _: UIAlertAction) {
            imagePicker.sourceType = .savedPhotosAlbum
            self.present(imagePicker, animated: true)
        }
        
        let albumsAction = UIAlertAction(title: "Saved Albums",
                                         style: .default,
                                         handler: presentAlbums)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        prompt.addAction(cameraAction)
        prompt.addAction(libraryAction)
        prompt.addAction(albumsAction)
        prompt.addAction(cancelAction)
        self.present(prompt, animated: true, completion: nil)
    }

    func performSlectionStateForButton(button : UIButton) {
        if button.isSelected {
            configureHighlightedButton(button: button)
        } else {
            configureUnHighlightedButton(button: button)
        }
    }

    func updateSelectionState() {
        performSlectionStateForButton(button: allButton)
        performSlectionStateForButton(button: failOnlyButton)
        performSlectionStateForButton(button: passOnlyButton)
        performSlectionStateForButton(button: noneButton)
    }
    
     @IBAction func editButtonAction(_ sender: Any) {
        photoButtonPressed(photoButton)
    }
    
    @IBAction func allButtonAction(_ sender: Any) {
        if !allButton.isSelected {
        allButton.isSelected = true
        } else {
            allButton.isSelected = false
        }
        noneButton.isSelected = false
        failOnlyButton.isSelected = false
        passOnlyButton.isSelected = false
        updateSelectionState()
    }

    
    @IBAction func failOnlyButtonAction(_ sender: Any) {
        if !failOnlyButton.isSelected {
        failOnlyButton.isSelected = true
        } else {
            failOnlyButton.isSelected = false
        }
        allButton.isSelected = false
        noneButton.isSelected = false
        updateSelectionState()
    }
    
    @IBAction func passOnlyButtonAction(_ sender: Any) {
        allButton.isSelected = false
        noneButton.isSelected = false
        if !passOnlyButton.isSelected {
        passOnlyButton.isSelected = true
        } else {
            passOnlyButton.isSelected = false
        }
        updateSelectionState()
    }
    
    @IBAction func noneOnlyButtonAction(_ sender: Any) {
        allButton.isSelected = false
        if !noneButton.isSelected {
        noneButton.isSelected = true
        } else {
            noneButton.isSelected = false
        }
        failOnlyButton.isSelected = false
        passOnlyButton.isSelected = false
        updateSelectionState()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        callSaveUserSettingAPI()
    }
    
    
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let originalImage = info[.originalImage] as? UIImage else {
            return
        }
        photoImageView.image = originalImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureHighlightedButton(button : UIButton) {
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.setImage(UIImage(named:"selected_checkbox"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    func configureUnHighlightedButton(button : UIButton) {
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named:"unselected_checkbox"), for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
    }
}
