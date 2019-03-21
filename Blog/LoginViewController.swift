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
    private let global = Global()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.underlined()
        self.passwordTextField.underlined()
        self.forgotYourPasswordButton.underlineText()
        self.getStartedButton.addTarget(self, action: #selector(getStarted), for: .touchDown)
    }
    
    @objc public func getStarted() {
        if self.global.defaults.bool(forKey: "userIsRegistered") == nil {
        self.infoCheck.check(viewController: self,
                             emailTextField: self.emailTextField,
                             passwordTextField: self.passwordTextField)
        } else {
            self.infoCheck.loginCheck(viewController: self,
                                      emailTextField: self.emailTextField,
                                      passwordTextField: passwordTextField)
        }
    }

}
