//
//  TableView.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 1/19/21.
//  Copyright © 2021 Mikalai Kuts. All rights reserved.
//

import Foundation
import UIKit

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    var tableView =  UITableView()
    var namesOfRows: [String] = []
    
    
    
    func createTableView() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "identifier")
        
        self.tableView.delegate = self as? UITableViewDelegate
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60.0
        
        view.addSubview(tableView)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesOfRows.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        let alcohols = AlcoholDao.fetchAll()
        let alcohol = alcohols[indexPath.row]
        let uiSwitch = createSwitch(alcohol: alcohol)
        cell.addSubview(uiSwitch)
        cell.textLabel?.text = alcohol.alcoholType
        
        return cell
    }
    
    func createSwitch(alcohol: Alcohol) -> AlcoholUISwitch{
        let createdSwitch = AlcoholUISwitch()
        createdSwitch.alcoholType = alcohol.alcoholType!
        createdSwitch.center = CGPoint(x: 330, y: 30)
        createdSwitch.addTarget(self, action: #selector(switchAction(sender:forEvent:)), for: UIControl.Event.valueChanged)
        createdSwitch.isOn = alcohol.isExist
        self.view.addSubview(createdSwitch)
        return createdSwitch
    }
    
    @objc func switchAction (sender: UISwitch, forEvent event: UIEvent){
        let alcoholSwitch = sender as? AlcoholUISwitch
        AlcoholDao.saveAlcoholType(alcoholType: alcoholSwitch!.alcoholType , isExist: sender.isOn)
    }
}
