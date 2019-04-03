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
    private let storage = Storage()
    public let indicator = ActivityIndicatorController()
    var view: LoginView?
    
    init(view: LoginView) {
        self.view = view
    }
    
    func registrationCheck(enteredEmail: String, enteredPassword: String) {
        
        if !self.storage.defaults.bool(forKey: "userIsRegistered") {
        guard enteredEmail.isValidEmail() else {
        self.view?.showInvalidEmail(enteredEmail: enteredEmail)
            return
        }
        guard enteredPassword.count >= 5 else {
            self.view?.showInvalidPassword(enteredPassword: enteredPassword)
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
                self.view?.goToMainVC()
            } else {
                self.view?.noData()
                }
            }
        } else {
            return
        }
    }
    
    func loginCheck(enteredEmail: String, enteredPassword: String) {
        if self.storage.defaults.bool(forKey: "userIsRegistered") {
        let savedEmail = self.storage.defaults.string(forKey: "email")
        let savedPassword = self.storage.defaults.string(forKey: "password")
        guard enteredEmail == savedEmail else {
            self.view?.showWrongEmail(enteredEmail: enteredEmail)
            return
        }
        guard enteredPassword == savedPassword else {
            self.view?.showWrongPassword(enteredPassword: enteredPassword)
            return
        }
        print("MOVING")
        print(self.storage.defaults.string(forKey: "token"))
        self.view?.goToMainVC()
        } else {
            return
        }
    }
        
    func setValues(enteredEmail: String, enteredPassword: String, newToken: String) {
        self.storage.defaults.set(String?(newToken), forKey: "token")
        print("GOT THE TOKEN!")
        print(newToken)
        self.storage.defaults.set(String(enteredEmail), forKey: "email")
        self.storage.defaults.set(String(enteredPassword), forKey: "password")
        self.storage.defaults.set(true, forKey: "userIsRegistered")
        }
    }
