//
//  ViewController.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 26/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController {
    
    let loadingViewController = LoadingViewController()
    let networkClient = NetworkManager()
    let router = Router.sharedInstance
    var cartBarButton: BadgedBarButtonItem?
    var alertBarButton: BadgedBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        if let count =  self.navigationController?.viewControllers.count , count > 1 {
            self.setBackBarButton()
        }else{
            if !(self is NotificationViewController) {
                self.setHeader()
            }
        }
        setRightBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        updateCartUnreadCount()
    }
    
    func updateCartUnreadCount() {
        if let model = kAppDelegate.cartInfoModel {
            cartBarButton?.badgeValue = model.cartItemTotal
        } else {
            cartBarButton?.badgeValue = 0 //model.cartItemTotal
        }
    }
    
    func setUpNavigationBar(){
        let robotoMedium  = Font(.installed(.robotoMedium), size: .standard(.hh2)).instance
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: robotoMedium as Any,  NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor  = UIColor.white
        //self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.charcoalGrey19.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 1
    }
    
    func cartButton() {
        let cartbarButton = BadgedBarButtonItem(
            startingBadgeValue: 0,
            frame: CGRect(x : 0,y : 0,width: 30,height : 30),
            image: UIImage(named :"shopping_cart"))
        cartbarButton.badgeProperties.backgroundColor = UIColor.cherryRed
        cartbarButton.badgeProperties.textColor = UIColor.white
        cartbarButton.addTarget(self, action: #selector(cartButtonAction))
        cartBarButton = cartbarButton
        cartbarButton.badgeProperties.backgroundColor = UIColor.cherryRed
        if let model = kAppDelegate.cartInfoModel {
            cartbarButton.badgeValue = model.cartItemTotal
        }
        let cartBarButtonItem  = cartBarButton
        
        let alertbarButton = BadgedBarButtonItem(
            startingBadgeValue: 0,
            frame: CGRect(x : 0,y : 0,width: 30,height : 30),
            image: UIImage(named :"notification")
        )
        alertbarButton.badgeProperties.backgroundColor = UIColor.cherryRed
        alertbarButton.badgeProperties.textColor = UIColor.white
        alertbarButton.addTarget(self, action: #selector(alertButtonAction))
        alertBarButton = alertbarButton
        alertBarButton?.badgeValue = 0
        let alertBarButtonItem  = alertBarButton
        self.navigationItem.rightBarButtonItems = [cartBarButtonItem,alertBarButtonItem] as? [UIBarButtonItem]
        
    }
    
    
 
    /**
     Set Navigation Rights bar Button item for notification and cart
     */
    func setRightBarButton() {
       if !(self is CartViewController || self is ReportViewController || self is NotificationViewController) {
            cartButton()
        } else {
            navigationItem.rightBarButtonItem =  nil
        }
    }
    
    
    
    
    /**
     Set Navigation Back Button
     */
    func setHeader() {
        let image = UIImage(named: "header_logo")
        let backBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func showToastOnTop(message: String){
        DispatchQueue.main.async {
            self.view.makeToast(message, duration: 2.0, position: .top, style: ToastStyle())
        }
    }
    
    func showToastOnCenter(message: String){
        self.view.makeToast(message, duration: 2.0, position: .center, style: ToastStyle())
    }
    
    @IBAction func cartButtonAction() {
        pushToCartViewController(cartType: .cart, cartDetail: nil)
    }
    
    @IBAction func alertButtonAction() {
        presentNotificationVC()
    }
    
    func presentNotificationVC() {
        let notificationViewController = UIStoryboard.notificationStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.notificationViewController)
        let nav = UINavigationController.init(rootViewController: notificationViewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    func delay(completionHandler: @escaping () -> Void) {
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            completionHandler()
        }
    }
    
    /**
     Set Navigation Back Button
     */
    func setBackBarButton() {
        let image = UIImage(named: "back")
        let backBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(self.actionBackNavigationItem))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     Back button action
     */
    @IBAction func actionBackNavigationItem() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

