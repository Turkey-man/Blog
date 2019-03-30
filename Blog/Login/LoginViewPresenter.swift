//
//  LoginViewPresenter.swift
//  Blog
//
//  Created by 1 on 30.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class LoginViewPresenter: LoginView {
    func check(viewController: LoginViewController) {
        guard let enteredEmail = viewController.emailTextField.text, enteredEmail.isValidEmail() else {
            viewController.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            viewController.emailTextField.underlined(color: UIColor.red)
            viewController.emailLabel.textColor = UIColor.red
            return
        }
        guard let enteredPassword = viewController.passwordTextField.text, enteredPassword.count >= 5 else {
            viewController.alertController.alert(title: "Invalid password", message: "Password must have at least 5 characters!", style: .alert, presentOn: viewController)
            viewController.emailTextField.underlined(color: UIColor.gray)
            viewController.emailLabel.textColor = UIColor.gray
            viewController.passwordTextField.underlined(color: UIColor.red)
            viewController.passwordLabel.textColor = UIColor.red
            return
        }
        
        Network.getToken { (login: Login) in
            if let newToken = login.token {
                print("NOT NIL")
                viewController.storage.defaults.set(String?(newToken), forKey: "token")
                print("GOT THE TOKEN!")
                print(newToken)
                viewController.storage.defaults.set(String(enteredEmail), forKey: "email")
                viewController.storage.defaults.set(String(enteredPassword), forKey: "password")
                viewController.storage.defaults.set(true, forKey: "userIsRegistered")
                viewController.goToMainVC()
            } else {
                viewController.emailTextField.underlined(color: UIColor.gray)
                viewController.emailLabel.textColor = UIColor.gray
                print(login.message)
                viewController.alertController.alert(title: "Error", message: "No data to display!", style: .alert, presentOn: viewController)
            }
        }
    }
    
    func loginCheck(viewController: LoginViewController) {
        let savedEmail = viewController.storage.defaults.string(forKey: "email")
        let savedPassword = viewController.storage.defaults.string(forKey: "password")
        
        guard let enteredEmail = viewController.emailTextField.text, enteredEmail == savedEmail  else {
            viewController.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            viewController.emailTextField.underlined(color: UIColor.red)
            viewController.emailLabel.textColor = UIColor.red
            return
        }
        guard let enteredPassword = viewController.passwordTextField.text, enteredPassword == savedPassword else {
            viewController.alertController.alert(title: "Wrong password", message: "You've entered the wrong password!", style: .alert, presentOn: viewController)
            viewController.emailTextField.underlined(color: UIColor.gray)
            viewController.emailLabel.textColor = UIColor.gray
            viewController.passwordTextField.underlined(color: UIColor.red)
            viewController.passwordLabel.textColor = UIColor.red
            return
        }
        print("MOVING")
        print(viewController.storage.defaults.string(forKey: "token"))
        
        viewController.goToMainVC()
    }
}
