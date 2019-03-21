//
//  InfoCheck.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class InfoCheck {
    private let global = Global()
    
    //Checking registration information
    public func check(viewController: UIViewController, emailTextField: UITextField, passwordTextField: UITextField) {
        guard let enteredEmail = emailTextField.text, enteredEmail.isValidEmail() else {
            self.global.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            return
        }
        guard let enteredPassword = passwordTextField.text, enteredPassword.count >= 5 else {
            self.global.alertController.alert(title: "Invalid password", message: "Password must have at least 5 characters!", style: .alert, presentOn: viewController)
            return
        }
        
        Network.getToken { (login: Login) in
            guard login.token != nil else { return }
            self.global.defaults.set(String?(login.token!), forKey: "token")
            print("GOT THE TOKEN!")
            print(login.token)
            
        }
        
        self.global.defaults.set(String(enteredEmail), forKey: "email")
        self.global.defaults.set(String(enteredPassword), forKey: "password")
        self.global.defaults.set(true, forKey: "userIsLoggedIn")
        viewController.performSegue(withIdentifier: "GetStarted", sender: nil)
    }
    
    //Checking login information
    public func loginCheck(viewController: UIViewController, emailTextField: UITextField, passwordTextField: UITextField) {
        let savedEmail = self.global.defaults.string(forKey: "email")
        let savedPassword = self.global.defaults.string(forKey: "password")
        
        guard let enteredEmail = emailTextField.text, enteredEmail == savedEmail  else {
            self.global.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            return
        }
        guard let enteredPassword = passwordTextField.text, enteredPassword == savedPassword else {
            self.global.alertController.alert(title: "Wrong password", message: "You've entered the wrong password!", style: .alert, presentOn: viewController)
            return
        }
        viewController.performSegue(withIdentifier: "GetStarted", sender: nil)
    }
}
