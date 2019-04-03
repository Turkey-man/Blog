//
//  LoginViewController.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotYourPasswordButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    
    public let alertController = UIAlertController()
    public var presenter: LoginViewPresenter!
    
    override public func viewWillAppear(_ animated: Bool) {
        self.emailTextField.underlined(color: UIColor.gray)
        self.passwordTextField.underlined(color: UIColor.gray)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginViewPresenter(view: self)
        self.forgotYourPasswordButton.underlineText()
        self.getStartedButton.addTarget(self, action: #selector(getStarted), for: .touchDown)
        self.hideKeyboard()
    }
    
    @objc public func getStarted() {
        presenter.registrationCheck(enteredEmail: self.emailTextField.text!, enteredPassword: self.passwordTextField.text!)
        presenter.loginCheck(enteredEmail: self.emailTextField.text!, enteredPassword: self.passwordTextField.text!)
        }

    func showInvalidEmail(enteredEmail: String) {
            self.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: self)
            self.emailTextField.underlined(color: UIColor.red)
            self.emailLabel.textColor = UIColor.red
    }
    
    func showInvalidPassword(enteredPassword: String) {
            self.alertController.alert(title: "Invalid password", message: "Password must have at least 5 characters!", style: .alert, presentOn: self)
            self.emailTextField.underlined(color: UIColor.gray)
            self.emailLabel.textColor = UIColor.gray
            self.passwordTextField.underlined(color: UIColor.red)
            self.passwordLabel.textColor = UIColor.red
    }
    
    func showWrongEmail(enteredEmail: String) {
            self.alertController.alert(title: "Wrong email", message: "Enter correct email!", style: .alert, presentOn: self)
            self.emailTextField.underlined(color: UIColor.red)
            self.emailLabel.textColor = UIColor.red
    }
    
    func showWrongPassword(enteredPassword: String) {
            self.alertController.alert(title: "Wrong password", message: "You've entered the wrong password!", style: .alert, presentOn: self)
            self.emailTextField.underlined(color: UIColor.gray)
            self.emailLabel.textColor = UIColor.gray
            self.passwordTextField.underlined(color: UIColor.red)
            self.passwordLabel.textColor = UIColor.red
    }
    
    func noData() {
        self.emailTextField.underlined(color: UIColor.gray)
        self.emailLabel.textColor = UIColor.gray
        self.alertController.alert(title: "Error", message: "No data to display!", style: .alert, presentOn: self)
    }

    func goToMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.present(controller, animated: true, completion: nil)
    }
}
