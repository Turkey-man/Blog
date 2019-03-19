//
//  NewsTableViewCell.swift
//  Blog
//
//  Created by 1 on 15.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class NewsTableViewCell: UITableViewCell {

    static let reusebleIdentifier = "custom"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleProjectTextView: UITextView!
    
}
