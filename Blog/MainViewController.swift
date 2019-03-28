//
//  MainViewController.swift
//  Blog
//
//  Created by 1 on 15.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var contentArray = [Content]()
    private let storage = Storage()
    private var indicator = ActivityIndicatorController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.goToNetwork()
        indicator.presentIndicator(on: self)
    }
    
    private func goToNetwork() {
        Network.getData { (something: ObtainedData) in
            if let data = something.content {
                self.contentArray = data
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopIndicator({
                    self.indicator.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    private func registerTableViewCell() {
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier) as! NewsTableViewCell
        let simple = self.contentArray[indexPath.row].shortName
        let name = self.contentArray[indexPath.row].name
        cell.simpleLabel.text = simple
        
        cell.simpleProjectTextView.text = name
        cell.cellImage.layer.cornerRadius = 8.0
        cell.cellImage.clipsToBounds = true
        return cell
        
    }
}
