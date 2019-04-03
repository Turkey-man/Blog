//
//  MainViewController.swift
//  Blog
//
//  Created by 1 on 15.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import UIKit

public class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MainView {
    @IBOutlet weak var tableView: UITableView!
    
    public var presenter: MainViewPresenter!
    private var indicator = ActivityIndicatorController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainViewPresenter(view: self)
        self.registerTableViewCell()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.goToNetwork()
        self.indicator.presentIndicator(on: self)
    }
    
    func fillArray(data: [Codable]) {
        self.presenter.contentArray = data as! [Content]
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.indicator.stopIndicator({
                self.indicator.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    private func registerTableViewCell() {
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.contentArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier) as! NewsTableViewCell
        let simple = self.presenter.contentArray[indexPath.row].shortName
        let name = self.presenter.contentArray[indexPath.row].name
        cell.simpleLabel.text = simple
        
        cell.simpleProjectTextView.text = name
        cell.cellImage.layer.cornerRadius = 8.0
        cell.cellImage.clipsToBounds = true
        return cell
        
    }
}
