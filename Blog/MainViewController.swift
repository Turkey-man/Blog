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
        
        self.setuptableView()
        Network.getData { (something: ObtainedData) in
            self.contentArray = something.content
            if something.content != nil {
            self.tableView.reloadData()
            } else {
                 self.alertController.alert(title: "Error", message: "Failed to retrieve data!", style: .alert, presentOn: self)
            }
        }
    }
    
    func setuptableView() {
         self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reusebleIdentifier)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reusebleIdentifier) as! NewsTableViewCell
        let simple = self.contentArray[indexPath.row].shortName
        let name = self.contentArray[indexPath.row].name
        cell.simpleLabel.text = simple
        cell.simpleProjectTextView.text = name
        cell.cellImage.layer.cornerRadius = 8.0
        cell.cellImage.clipsToBounds = true
        return cell
    }
}
