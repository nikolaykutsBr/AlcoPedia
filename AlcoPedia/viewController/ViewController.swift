//
//  ViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/26/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource {
    
    var cellsCounter: Int = 0
    var tableView =  UITableView()
    let identifier = "MyCell"
    let alcoholTypes: [String] = ["Vodka","Gin","Tequila","Triple sec","123","Vodka1","Gi2n","Te3quila","Tr4iple sec","5123","Vo3dka","Gi4n","Teq5uila","Tri6ple sec","1273"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bar"
        
        populateDataBase()
        createTableView()
        
    }
    
    func createTableView() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        self.tableView.delegate = self as? UITableViewDelegate
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60.0
        
        view.addSubview(tableView)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return alcoholTypes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let alcohols = AlcoholDao.fetchAll()
        
        if cellsCounter < alcoholTypes.count{
            let alcohol = alcohols[cellsCounter]
            let uiSwitch = createSwitch(alcohol: alcohol)
            cell.addSubview(uiSwitch)
            cell.textLabel?.text = alcohol.alcoholType
            cellsCounter += 1
        }
        return cell
    }
    
    func populateDataBase(){
        for alcoholType in alcoholTypes{
            let isExist = AlcoholDao.checkRecordExists(alcoholType: alcoholType)
            if !isExist {
                AlcoholDao.saveAlcoholType(alcoholType: alcoholType, isExist: true)
            }
        }
    }
    
    //Checking alcohol in DB and set state of UISwitch
    
    func checkAvaliableAlcohol(alcoholType: Alcohol! ,alcoholSwitch: UISwitch){
        if alcoholType != nil {
            alcoholSwitch.setOn(alcoholType!.isExist, animated: true)
        } else {
            alcoholSwitch.setOn(true, animated: true)
        }
    }
    
    //Programmaticaly creating switch
    
    func createSwitch(alcohol: Alcohol) -> AlcoholUISwitch{
        let createdSwitch = AlcoholUISwitch()
        createdSwitch.alcoholType = alcohol.alcoholType!
//        createdSwitch.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 30, leading: 250, bottom: 30, trailing: 20)
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
    
    //Programmaticaly creating button
    
    func createButtonToVeiw(x: Int,y: Int, width: Int, height: Int) -> UIButton {
        let createButton = UIButton()
        createButton.frame = CGRect(x: x, y: y, width: width, height: height)
        self.view.addSubview(createButton)
        return createButton
    }
   
    //Programmaticaly creating label of alcohol
    
    func createLabelForAlcohol(label: String, x: Int, y: Int, width: Int, height: Int) -> UILabel{
        let createlabel = UILabel()
        createlabel.frame = CGRect(x: x, y: y, width: width, height: height)
        createlabel.textAlignment = .center
        createlabel.text = label
        self.view.addSubview(createlabel)
        return createlabel
    }

}

