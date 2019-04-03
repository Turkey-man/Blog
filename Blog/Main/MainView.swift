//
//  MainView.swift
//  Blog
//
//  Created by 1 on 29.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

protocol MainView {
    func fillArray(data: [Codable])
    func reloadTable()
}
