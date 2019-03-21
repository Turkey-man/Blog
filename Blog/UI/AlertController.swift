//
//  AlertController.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

extension UIAlertController {
    public func alert(title: String, message: String, style: UIAlertControllerStyle, presentOn: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
        }
        
        alertController.addAction(action)
        presentOn.present(alertController, animated: true, completion: nil)
    }
}
