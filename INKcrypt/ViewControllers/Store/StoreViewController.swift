//
//  StoreViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import SVPullToRefresh

class StoreViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productArray = [ProductListElement]()
    var currentPage: Int64 = 0
    var totalPage: Int64 = 0
    
    var refreshControl = UIRefreshControl()
    var isRereshAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.getProduct()
    }
    
    func initializeView(){
        self.title = PageTitleStrings.store.localized
        
        self.tableView.estimatedRowHeight = 300.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        
        self.refreshControl.addTarget(self, action: #selector(StoreViewController.refreshAction(_ : )), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        //        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        //        self.tableView.estimatedSectionHeaderHeight = 100.0
        
        self.registerCell()
        self.configurePaging()
        self.getProduct()
    }
    
    func registerCell(){
        let simpleStoreTableViewCell = UINib(nibName: Constants.CellIdentifier.simpleStoreTableViewCell, bundle: nil)
        self.tableView.register(simpleStoreTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.simpleStoreTableViewCell)
        
        let newExistingStoreTableViewCell = UINib(nibName: Constants.CellIdentifier.newExistingStoreTableViewCell, bundle: nil)
        self.tableView.register(newExistingStoreTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.newExistingStoreTableViewCell)
        
        let codeStoreTableViewCell = UINib(nibName: Constants.CellIdentifier.codeStoreTableViewCell, bundle: nil)
        self.tableView.register(codeStoreTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.codeStoreTableViewCell)
        
        let storeTableViewSection = UINib(nibName: Constants.CellIdentifier.storeTableViewSection, bundle: nil)
        self.tableView.register(storeTableViewSection, forHeaderFooterViewReuseIdentifier: Constants.CellIdentifier.storeTableViewSection)
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
    
    func getProduct(){
        if !isRereshAction {
            add(loadingViewController)
        }
        
        router.serviceForEndPoint(apiType: .productList(pageIndex: (self.currentPage + 1), pageSize: 10), decodingType: StoreElement.self) { [weak self] (result) in
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
                        if let productList = model?.productListElements {
                            if self?.isRereshAction ?? false {
                                self?.isRereshAction = false
                                self?.productArray.removeAll()
                                self?.productArray.append(contentsOf: productList)
                                self?.tableView.reloadData()
                                
                            }else {
                                self?.productArray.append(contentsOf: productList)
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
