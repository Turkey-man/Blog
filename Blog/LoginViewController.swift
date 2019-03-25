//
//  LoginViewController.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class LoginViewController: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotYourPasswordButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    
    private let infoCheck = InfoCheck()
    private let storage = Storage()
    private let alertController = UIAlertController()
    private let mainVC = MainViewController()
    
    override public func viewWillAppear(_ animated: Bool) {
        self.emailTextField.underlined(color: UIColor.gray)
        self.passwordTextField.underlined(color: UIColor.gray)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        
//        self.emailTextField.underlined(color: UIColor.gray)
//        self.passwordTextField.underlined(color: UIColor.gray)
        self.forgotYourPasswordButton.underlineText()
        self.getStartedButton.addTarget(self, action: #selector(getStarted), for: .touchDown)
    }
    
    @objc public func getStarted() {
        if self.storage.defaults.bool(forKey: "userIsRegistered") {
            self.loginCheck(viewController: self,
                            emailTextField: self.emailTextField,
                            passwordTextField: self.passwordTextField)
        } else {
            self.check(viewController: self,
                       emailTextField: self.emailTextField,
                       passwordTextField: self.passwordTextField)
        }
    }

    //Checking registration information
    public func check(viewController: UIViewController, emailTextField: UITextField, passwordTextField: UITextField) {
        guard let enteredEmail = emailTextField.text, enteredEmail.isValidEmail() else {
            self.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            self.emailTextField.underlined(color: UIColor.red)
            self.emailLabel.textColor = UIColor.red
            return
        }
        guard let enteredPassword = passwordTextField.text, enteredPassword.count >= 5 else {
            self.alertController.alert(title: "Invalid password", message: "Password must have at least 5 characters!", style: .alert, presentOn: viewController)
            self.emailTextField.underlined(color: UIColor.gray)
            self.emailLabel.textColor = UIColor.gray
            self.passwordTextField.underlined(color: UIColor.red)
            self.passwordLabel.textColor = UIColor.red
            return
        }
        
        Network.getToken { (login: Login) in
            if let newToken = login.token {
            print("NOT NIL")
            self.storage.defaults.set(String?(newToken), forKey: "token")
            print("GOT THE TOKEN!")
            print(newToken)
            self.storage.defaults.set(String(enteredEmail), forKey: "email")
            self.storage.defaults.set(String(enteredPassword), forKey: "password")
            self.storage.defaults.set(true, forKey: "userIsRegistered")
                self.present(self.mainVC, animated: true, completion: nil)
            } else {
                self.emailTextField.underlined(color: UIColor.gray)
                self.emailLabel.textColor = UIColor.gray
                print(login.message)
                self.alertController.alert(title: "Error", message: "No data to display!", style: .alert, presentOn: viewController)
            }
        }
    }
    
    //Checking login information
    public func loginCheck(viewController: UIViewController, emailTextField: UITextField, passwordTextField: UITextField) {
        let savedEmail = self.storage.defaults.string(forKey: "email")
        let savedPassword = self.storage.defaults.string(forKey: "password")
        
        guard let enteredEmail = emailTextField.text, enteredEmail == savedEmail  else {
            self.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            self.emailTextField.underlined(color: UIColor.red)
            self.emailLabel.textColor = UIColor.red
            return
        }
        guard let enteredPassword = passwordTextField.text, enteredPassword == savedPassword else {
            self.alertController.alert(title: "Wrong password", message: "You've entered the wrong password!", style: .alert, presentOn: viewController)
            self.emailTextField.underlined(color: UIColor.gray)
            self.emailLabel.textColor = UIColor.gray
            self.passwordTextField.underlined(color: UIColor.red)
            self.passwordLabel.textColor = UIColor.red
            return
        }
        print("MOVING")
        print(storage.defaults.string(forKey: "token"))
        self.present(self.mainVC, animated: true, completion: nil)
    }
}


