//
//  RegEx.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Foundation

extension String {
    public func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regEx = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regEx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
