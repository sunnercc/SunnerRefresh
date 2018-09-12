//
//  ViewController.swift
//  SunnerRefresh-Example-iOS
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit
import SunnerRefresh

let cellID = "cellID"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tableview = UITableView(frame: self.view.bounds, style: .plain)
        tableview.backgroundColor = .yellow
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
//        tableview.contentInsetAdjustmentBehavior = .never
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellID)
        
        let header = SunnerRefreshHeader()
        tableview.sunnerRefreshHeader = header
        tableview.sunnerRefreshHeader?.backgroundColor = .red
        tableview.sunnerRefreshHeader?.refreshing(target: self, action: #selector(self.headerAction))
//
//        let footer = SunnerRefreshFooter()
//        tableview.sunnerRefreshFooter = footer
//        tableview.sunnerRefreshFooter?.backgroundColor = .blue
//        tableview.sunnerRefreshFooter?.refreshing(target: self, action: #selector(self.footerAction))
    }
    
    @objc func headerAction() {
        print("headerAction")
    }
    
    @objc func footerAction() {
        print("footerAction")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.detailTextLabel?.text = "detail text label"
        cell.textLabel?.text = "text label"
        return cell
    }
}

