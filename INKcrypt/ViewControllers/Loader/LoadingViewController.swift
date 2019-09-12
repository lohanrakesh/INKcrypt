//
//  LoadingViewController.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import UIKit
/*
 Usage :
 let loadingViewController = LoadingViewController()
 add(loadingViewController)
 */
class LoadingViewController: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = UIColor.appDefaultColor()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
}
