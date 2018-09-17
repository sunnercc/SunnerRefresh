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

    var tableview: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tableview = UITableView(frame: self.view.bounds, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
//        tableview.contentInsetAdjustmentBehavior = .never
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellID)
        self.tableview = tableview
        
        let header = SunnerIndicatorRefreshHeader(inView: tableview)
        header.refreshing(target: self, action: #selector(self.headerAction))
        tableview.sunnerRefreshHeader = header

        let footer = SunnerIndicatorRefreshFooter(inView: tableview)
        footer.refreshing(target: self, action: #selector(self.footerAction))
        tableview.sunnerRefreshFooter = footer
    }
    
    @objc func headerAction() {
        DispatchQueue.global().async {
            for i in 0...100000 {
                print(i)
            }
            DispatchQueue.main.async {
                self.tableview?.sunnerRefreshHeader?.endRefresh()
            }
        }
    }
    
    @objc func footerAction() {
        DispatchQueue.global().async {
            for i in 0...100000 {
                print(i)
            }
            DispatchQueue.main.async {
                self.tableview?.sunnerRefreshFooter?.endRefresh()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.detailTextLabel?.text = "detail text label"
        cell.textLabel?.text = "text label"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("test")
    }
}

