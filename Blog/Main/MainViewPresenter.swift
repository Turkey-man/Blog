//
//  MainViewPresenter.swift
//  Blog
//
//  Created by 1 on 29.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class MainViewPresenter {

    public var contentArray = [Content]()
    var view: MainView?
    
    init(view: MainView) {
        self.view = view
    }
    
    public func goToNetwork() {
        Network.getData { (something: ObtainedData) in
            if let data = something.content {
                self.view?.fillArray(data: data)
            }
            self.view?.reloadTable()
        }
    }
}
