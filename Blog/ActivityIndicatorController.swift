//
//  ActivityIndicatorController.swift
//  Blog
//
//  Created by 1 on 28.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class ActivityIndicatorController: UIViewController {
    
    private var indicator: UIActivityIndicatorView = {
        let size: CGFloat = 200
        let indicator = UIActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.midX - size / 2 , y:  UIScreen.main.bounds.midY - size / 2, width: size, height: size))
        indicator.color = .white
        indicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = 20
        
        return indicator
    }()
    
   private func setupActivityIndicatorController() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    func presentIndicator(on: UIViewController?) {
        setupActivityIndicatorController()
        on?.present(self, animated: true, completion: nil)
    }
    
    func stopIndicator(_ completionHandler: (() -> ())?) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.dismiss(animated: true, completion: completionHandler)
        }
    }

    private var label: UILabel = {
        let size: CGFloat = 200
        let label = UILabel(frame: CGRect(x: 75, y: 75, width: size, height: size))
        label.text = "Loading..."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupIndicator()
    }
    
  private func setupIndicator() {
        indicator.addSubview(label)
        self.view.addSubview(indicator)
        self.setupPresentation()
    }
    
    private func setupPresentation() {
        self.view.backgroundColor = .clear
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
}

