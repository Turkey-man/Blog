//
//  LoginViewPresenter.swift
//  Blog
//
//  Created by 1 on 30.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class LoginViewPresenter {
    
    public var contentArray = [Content]()
    public let storage = Storage()
    public let indicator = ActivityIndicatorController()
    var view: LoginView?
    
    init(view: LoginView) {
        self.view = view
    }
    
    func check(enteredEmail: String, enteredPassword: String) {
        self.view?.showInvalidEmail(enteredEmail: enteredEmail)
//        guard let enteredEmail = viewController.emailTextField.text, enteredEmail.isValidEmail() else {
//            viewController.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
//            viewController.emailTextField.underlined(color: UIColor.red)
//            viewController.emailLabel.textColor = UIColor.red
//            return
//        }
        self.view?.showInvalidPassword(enteredPassword: enteredPassword)
//        guard let enteredPassword = viewController.passwordTextField.text, enteredPassword.count >= 5 else {
//            viewController.alertController.alert(title: "Invalid password", message: "Password must have at least 5 characters!", style: .alert, presentOn: viewController)
//            viewController.emailTextField.underlined(color: UIColor.gray)
//            viewController.emailLabel.textColor = UIColor.gray
//            viewController.passwordTextField.underlined(color: UIColor.red)
//            viewController.passwordLabel.textColor = UIColor.red
//            return
//        }
        Network.getToken { (login: Login) in
            if let newToken = login.token {
                print("NOT NIL")
                self.storage.defaults.set(String?(newToken), forKey: "token")
                print("GOT THE TOKEN!")
                print(newToken)
                self.storage.defaults.set(String(enteredEmail), forKey: "email")
                self.storage.defaults.set(String(enteredPassword), forKey: "password")
                self.storage.defaults.set(true, forKey: "userIsRegistered")
                self.view?.goToMainVC()
                //viewController.goToMainVC()
            } else {
                self.view?.noData()
//                viewController.emailTextField.underlined(color: UIColor.gray)
//                viewController.emailLabel.textColor = UIColor.gray
//                print(login.message)
//                viewController.alertController.alert(title: "Error", message: "No data to display!", style: .alert, presentOn: viewController)
            }
        }
    }
    
    func loginCheck(enteredEmail: String, enteredPassword: String) {
        let savedEmail = self.storage.defaults.string(forKey: "email")
        let savedPassword = self.storage.defaults.string(forKey: "password")
        self.view?.showWrongEmail(enteredEmail: enteredEmail)
//        guard let enteredEmail = viewController.emailTextField.text, enteredEmail == savedEmail  else {
//            viewController.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
//            viewController.emailTextField.underlined(color: UIColor.red)
//            viewController.emailLabel.textColor = UIColor.red
//            return
//        }
        self.view?.showWrongPassword(enteredPassword: enteredPassword)
//        guard let enteredPassword = viewController.passwordTextField.text, enteredPassword == savedPassword else {
//            viewController.alertController.alert(title: "Wrong password", message: "You've entered the wrong password!", style: .alert, presentOn: viewController)
//            viewController.emailTextField.underlined(color: UIColor.gray)
//            viewController.emailLabel.textColor = UIColor.gray
//            viewController.passwordTextField.underlined(color: UIColor.red)
//            viewController.passwordLabel.textColor = UIColor.red
//            return
//        }
        print("MOVING")
        print(self.storage.defaults.string(forKey: "token"))
        self.view?.goToMainVC()
    }
}
