//
//  ProfileViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 1/1/21.
//  Copyright © 2021 Mikalai Kuts. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {

    private var tableView =  UITableView()
    private let namesOfRows: [String] = ["Settings","Fortune Wheel"]
    private let settingsButton = UINavigationItem()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        settingsButton.rightBarButtonItem = UIBarButtonItem.init(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonAction))
        
        createTableView()
    }
    
    
    @objc private func settingsButtonAction(){
        print("Button pressed")
    }
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesOfRows.count
    }
    
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        cell.textLabel?.text = namesOfRows[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    private func createTableView() {
        
        self.tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        
        self.tableView.delegate = self as? UITableViewDelegate
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60.0
        
        view.addSubview(tableView)
        
    }

}
