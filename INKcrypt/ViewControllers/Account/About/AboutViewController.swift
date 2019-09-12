//
//  AboutViewController.swift
//  INKcrypt
//
//  Created by Asif on 28/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: ViewController ,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var type : WebViewAction = WebViewAction.about
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        initialiseWebView()
        // Do any additional setup after loading the view.
    }
    
    private func initialiseWebView()  {
        activityIndicator.startAnimating()
        self.webView.navigationDelegate = self
        //        activityIndicator.hidesWhenStopped = true
        //        if let url = URL(string: "http://www.q3tech.com/who-we-are/") {
        //            let req = URLRequest(url: url)
        //            webView?.load(req)
        //        }
        if type == .about {
            self.getAboutUsData()
        }else {
            self.getTermConditionData()
        }
    }
    
    func getAboutUsData(){
        //add(loadingViewController)
        
        router.serviceForEndPoint(apiType: .aboutUs, decodingType: ForgotPassword.self) {[weak self] (result) in
//            DispatchQueue.main.async {
//                self?.loadingViewController.remove()
//            }
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {return}
                if  response.success {
                    if let aboutUs = model {
                        DispatchQueue.main.async {
                            self?.webView.loadHTMLString(aboutUs.message ?? "", baseURL: nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showToastOnTop(message: response.message ?? "")
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    func getTermConditionData(){
        add(loadingViewController)
        
        router.serviceForEndPoint(apiType: .termCondition, decodingType: ForgotPassword.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {return}
                if  response.success {
                    if let termCondition = model {
                        DispatchQueue.main.async {
                            self?.webView.loadHTMLString(termCondition.message ?? "", baseURL: nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showToastOnTop(message: response.message ?? "")
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // MARK: - Custom Method
    private func setNavBarTitle() {
        if type == .termAndCondition {
            self.title = PageTitleStrings.termAndCondition.localized
        } else {
            self.title = PageTitleStrings.about.localized
        }
    }
}
