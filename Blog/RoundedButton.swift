//
//  RoundedButton.swift
//  Blog
//
//  Created by 1 on 18.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class RoundedButton: UIButton {
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2/UIScreen.main.nativeScale
        layer.borderColor = UIColor.blue.cgColor
        contentEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 9)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.borderColor = tintColor.cgColor
    }
}
