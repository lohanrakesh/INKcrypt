//
//  HomeViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 08/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeModel: HomeModel?
    var currentPage: Int64 = 0
    var totalPage: Int64 = 0
    
    var refreshControl = UIRefreshControl()
    var isRereshAction = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.title = PageTitleStrings.home.localized
        
        self.tableView.estimatedRowHeight = 400.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()

        self.refreshControl.addTarget(self, action: #selector(StoreViewController.refreshAction(_ : )), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.registerCell()
        self.configurePaging()
        self.getProduct()
    }
    
    func registerCell(){
        let homeHeaderTableViewCell = UINib(nibName: Constants.CellIdentifier.homeHeaderTableViewCell, bundle: nil)
        self.tableView.register(homeHeaderTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.homeHeaderTableViewCell)
        
        let homeProductTableViewCell = UINib(nibName: Constants.CellIdentifier.homeProductTableViewCell, bundle: nil)
        self.tableView.register(homeProductTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.homeProductTableViewCell)
        
        let homeReportActivityTableViewCell = UINib(nibName: Constants.CellIdentifier.homeReportActivityTableViewCell, bundle: nil)
        self.tableView.register(homeReportActivityTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.homeReportActivityTableViewCell)
    }
    
    @objc func refreshAction(_ sender: UIRefreshControl){
        isRereshAction = true
        currentPage = 0
        self.getProduct()
    }
    
    func configurePaging() {
        
        self.tableView.addInfiniteScrolling {
            if !(self.currentPage == self.totalPage) {
                self.getProduct()
            } else {
                self.tableView.infiniteScrollingView.stopAnimating()
            }
        }
    }
    
    //MARK:- API
    func getProduct(){
        if !isRereshAction {
            add(loadingViewController)
        }
        
        let parameter = ["PageIndex": 1, "PageSize": 10, "CountryCode":"+91", "CustomerLevelID": 1] as [String : Any]
        
            router.serviceForEndPoint(apiType: .home(model: parameter), decodingType: HomeModel.self) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()
                self?.loadingViewController.remove()
                switch result {
                case .success(let responseData, let model):
                    guard let response = responseData else {return}
                    debugPrint("Response data :- \(response)")
                    if  response.success {
                        if let total = response.totalPage, let current = response.currentPage {
                            self?.totalPage = total
                            self?.currentPage = current
                        }
                        
                        if let object = model {
                            debugPrint("Home model:- \(object)")
                            if self?.isRereshAction ?? false {
                                self?.isRereshAction = false
                                self?.homeModel = object
                                self?.tableView.reloadData()

                            }else {
                                self?.homeModel?.productDataList.products.append(contentsOf: object.productDataList.products)
                                //append(object.productDataList.products)
                                self?.tableView.reloadData()
                            }
                        }
                    } else {
                        self?.showToastOnTop(message: response.message ?? "")
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
        }
    }

}
