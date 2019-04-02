//
//  MainViewPresenter.swift
//  Blog
//
//  Created by 1 on 29.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class MainViewPresenter {

//    weak public var viewController: UIViewController?
    public var contentArray = [Content]()
    var view: MainView?
    public func goToNetwork() {
        Network.getData { (something: ObtainedData) in
            if let data = something.content {
                self.view?.fillArray(data: data)
            }
            self.view?.reloadTable()
        }
    }
}
