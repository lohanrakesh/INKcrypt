//
//  UIViewControllerExtension.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func pushToSignUpViewController(){
        guard let signUpViewController = UIStoryboard.signInStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.signUpViewController) as? SignUpViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func pushToForgotPasswordViewController(){
        guard let forgotPasswordViewController = UIStoryboard.signInStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.forgotPasswordViewController) as? ForgotPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    func pushToVerficationCodeViewController(){
        guard let verficationCodeViewController = UIStoryboard.signInStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.verficationCodeViewController) as? VerficationCodeViewController else {
            return
        }
        self.navigationController?.pushViewController(verficationCodeViewController, animated: true)
    }
    
    func pushToPatternDetailViewController(_ imagePattern: ImagePatternResponse?, qrId:String?, qrImage:UIImage?){
        
        let patternDetailViewController = AppStoryboard.authenticate.viewController(viewControllerClass: PatternDetailViewController.self)
        patternDetailViewController.imagePattern = imagePattern
        patternDetailViewController.qrId = qrId?.components(separatedBy: "?a=").last
        patternDetailViewController.qrCodeImage = qrImage
        self.navigationController?.pushViewController(patternDetailViewController, animated: true)
        
    }
    
    func pushToProfileViewController(){
        guard let profileViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.profileViewController) as? ProfileViewController else {
            return
        }
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func pushToOrderViewController(){
        guard let profileViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.orderViewController) as? OrderViewController else {
            return
        }
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    
    func pushToSavedCardViewController(){
        guard let savedCardViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.savedCardViewController) as? SavedCardViewController else {
            return
        }
        self.navigationController?.pushViewController(savedCardViewController, animated: true)
    }
    
    func pushToSettingsViewController() {
        guard let viewC = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.settingsViewController) as? SettingsViewController else {
            return
        }
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    func pushToCardViewController(){
        guard let savedCardViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.cardViewController) as? CardViewController else {
            return
        }
        self.navigationController?.pushViewController(savedCardViewController, animated: true)
    }
    
    func pushToCartViewController(cartType : CartType, cartDetail : CartDetail?) {
        guard let cartViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.cartViewController) as? CartViewController else {
            return
        }
        cartViewController.cartType = cartType
        cartViewController.cartDetail = cartDetail
        cartViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    
    func pushToTestResultViewController(){
        guard let testResultViewController = UIStoryboard.authenticateStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.testResultViewController) as? TestResultViewController else {
            return
        }
        self.navigationController?.pushViewController(testResultViewController, animated: true)
    }
    
    
    func pushToChangePasswordViewController(){
        guard let testResultViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.changePasswordViewController) as? ChangePasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(testResultViewController, animated: true)
    }
    
    func pushToContactSupportViewController(){
        guard let contactSupportViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.contactSupportViewController) as? ContactSupportViewController else {
            return
        }
        self.navigationController?.pushViewController(contactSupportViewController, animated: true)
    }
    
    func pushToAddressViewController(){
        guard let addressViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.addressViewController) as? AddressViewController else {
            return
        }
        self.navigationController?.pushViewController(addressViewController, animated: true)
    }
    
    func pushToAboutViewController(actionType : WebViewAction){
        guard let aboutViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.aboutViewController) as? AboutViewController else {
            return
        }
        aboutViewController.type = actionType
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    func pushToTabBarViewController(){
        guard let tabBarViewController = UIStoryboard.tabStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.tabBarViewController) as? TabBarViewController else {
            return
        }
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
   
    
    //Register
    func pushToRegisterDetailViewController(){
        guard let registerDetailViewController = UIStoryboard.registerStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.registerDetailViewController) as? RegisterDetailViewController else {
            return
        }
        self.navigationController?.pushViewController(registerDetailViewController, animated: true)
    }
    
    func pushToReportViewController(){
        guard let reportViewController = UIStoryboard.reportStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.reportViewController) as? ReportViewController else {
            return
        }
        self.navigationController?.pushViewController(reportViewController, animated: true)
    }
    
    func pushToReportDetailViewController(spotData: MapInfoWindowModel?){
        guard let reportDetailViewController = UIStoryboard.reportStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.reportDetailViewController) as? ReportDetailViewController else {
            return
        }
        reportDetailViewController.markerData = spotData
        self.navigationController?.pushViewController(reportDetailViewController, animated: true)
    }
    func pushToMyBioMarkersCodesViewController(){
        guard let myBiomarkersViewController = UIStoryboard.bioMarkersCodesStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.myBiomarkersViewController) as? MyBiomarkersViewController else {
            return
        }
        self.navigationController?.pushViewController(myBiomarkersViewController, animated: true)
    }
}
