//
//  LoginView.swift
//  Blog
//
//  Created by 1 on 30.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

protocol LoginView {
    func showInvalidEmail(enteredEmail: String)
    func showInvalidPassword(enteredPassword: String)
    func showWrongEmail(enteredEmail: String)
    func showWrongPassword(enteredPassword: String)
    func goToMainVC()
    func noData()
}
