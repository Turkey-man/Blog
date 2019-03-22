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
    
    private let storage = Storage()
    private let alertController = UIAlertController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        
        self.emailTextField.useUnderline(color: UIColor.gray)
        self.passwordTextField.useUnderline(color: UIColor.gray)
        self.forgotYourPasswordButton.underlineText()
        self.getStartedButton.addTarget(self, action: #selector(getStarted), for: .touchDown)
    }
    
    @objc public func getStarted() {
        if self.storage.defaults.bool(forKey: "userIsRegistered") != true {
        self.check(viewController: self,
                             emailTextField: self.emailTextField,
                             passwordTextField: self.passwordTextField)
        } else {
            self.loginCheck(viewController: self,
                                      emailTextField: self.emailTextField,
                                      passwordTextField: passwordTextField)
        }
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    //Checking registration information
    public func check(viewController: UIViewController, emailTextField: UITextField, passwordTextField: UITextField) {
        guard let enteredEmail = emailTextField.text, enteredEmail.isValidEmail() else {
            self.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            self.emailTextField.useUnderline(color: UIColor.red)
            self.emailLabel.textColor = UIColor.red
            return
        }
        guard let enteredPassword = passwordTextField.text, enteredPassword.count >= 5 else {
            self.alertController.alert(title: "Invalid password", message: "Password must have at least 5 characters!", style: .alert, presentOn: viewController)
            self.emailTextField.useUnderline(color: UIColor.gray)
            self.emailLabel.textColor = UIColor.gray
            self.passwordTextField.useUnderline(color: UIColor.red)
            self.passwordLabel.textColor = UIColor.red
            return
        }
        
        Network.getToken { (login: Login) in
            guard login.token != nil else { return }
            self.storage.defaults.set(String?(login.token!), forKey: "token")
            print("GOT THE TOKEN!")
            print(login.token)
            
        }
        
        self.storage.defaults.set(String(enteredEmail), forKey: "email")
        self.storage.defaults.set(String(enteredPassword), forKey: "password")
        self.storage.defaults.set(true, forKey: "userIsRegistered")
        
        viewController.performSegue(withIdentifier: "GetStarted", sender: nil)
    }
    
    //Checking login information
    public func loginCheck(viewController: UIViewController, emailTextField: UITextField, passwordTextField: UITextField) {
        let savedEmail = self.storage.defaults.string(forKey: "email")
        let savedPassword = self.storage.defaults.string(forKey: "password")
        
        guard let enteredEmail = emailTextField.text, enteredEmail == savedEmail  else {
            self.storage.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: viewController)
            self.emailTextField.useUnderline(color: UIColor.red)
            self.emailLabel.textColor = UIColor.red
            return
        }
        guard let enteredPassword = passwordTextField.text, enteredPassword == savedPassword else {
            self.storage.alertController.alert(title: "Wrong password", message: "You've entered the wrong password!", style: .alert, presentOn: viewController)
            self.emailTextField.useUnderline(color: UIColor.gray)
            self.emailLabel.textColor = UIColor.gray
            self.passwordTextField.useUnderline(color: UIColor.red)
            self.passwordLabel.textColor = UIColor.red
            return
        }
        viewController.performSegue(withIdentifier: "GetStarted", sender: nil)
    }
}

extension UITextField {
    
    func useUnderline(color: UIColor) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        border.bounds = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
