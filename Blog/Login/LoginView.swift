//
//  LoginView.swift
//  Blog
//
//  Created by 1 on 30.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

protocol LoginView {
//    func check(enteredEmail: String, enteredPassword: String)
//    func loginCheck(enteredEmail: String, enteredPassword: String)
    func showInvalidEmail(enteredEmail: String, enteredPassword: String)
    func showInvalidPassword(enteredEmail: String, enteredPassword: String)
    func showWrongEmail(enteredEmail: String, enteredPassword: String)
    func showWrongPassword(enteredEmail: String, enteredPassword: String)
    func goToMainVC()
    func noData()
}
