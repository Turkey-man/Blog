//
//  MainViewController.swift
//  Blog
//
//  Created by 1 on 15.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit
import Alamofire

public class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var contentArray = [Content]()
    private let storage = Storage()
    private let alertController = UIAlertController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "custom")
        Network.getData { (something: ObtainedData) in
            self.contentArray = something.content
            self.tableView.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! NewsTableViewCell
        let simple = self.contentArray[indexPath.row].shortName
        let name = self.contentArray[indexPath.row].name
        cell.simpleLabel.text = simple
        cell.simpleProjectTextView.text = name
        cell.cellImage.layer.cornerRadius = 8.0
        cell.cellImage.clipsToBounds = true
        return cell
    }
}
