//
//  MainViewPresenter.swift
//  Blog
//
//  Created by 1 on 29.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class MainViewPresenter: MainView {
 
//    private var indicator = ActivityIndicatorController()
//    weak public var viewController: UIViewController?
    
    public func goToNetwork(VC: MainViewController, tableView: UITableView, indicator: ActivityIndicatorController) {
        Network.getData { (something: ObtainedData) in
            if let data = something.content {
                VC.contentArray = data
            }
            DispatchQueue.main.async {
                tableView.reloadData()
                indicator.stopIndicator({
                    indicator.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    
}

