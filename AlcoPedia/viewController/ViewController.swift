//
//  ViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/26/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource {
    
    private var searchResult: [String] = []
    private var cellsCounter: Int = 0
    private var tableView =  UITableView()
    private let identifier = "MyCell"
    private let alcoholTypes: [String] = ["Vodka","Gin","Tequila","Triple sec","123","Vodka1","Gi2n","Te3quila","Tr4iple sec","5123","Vo3dka","Gi4n","Teq5uila","Tri6ple sec","1273"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bar"
        
        
        setUpNavigationBar()
        populateDataBase()
        createTableView()
    }
    

    
    // Creating table view and cells
    
    private func createTableView() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        self.tableView.delegate = self as? UITableViewDelegate
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60.0
        
        view.addSubview(tableView)
        
    }
    
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return alcoholTypes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let alcohols = AlcoholDao.fetchAll()
        let alcohol = alcohols[indexPath.row]
        
        cell.textLabel?.text = alcohol.alcoholType
        if cellsCounter < alcoholTypes.count{
            let uiSwitch = createSwitch(alcohol: alcohol)
            cell.addSubview(uiSwitch)
            cell.accessoryType = .disclosureIndicator
            cellsCounter += 1
        } 
        return cell
    }
    
    
    // Populate database
    
    private func populateDataBase(){
        for alcoholType in alcoholTypes{
            let isExist = AlcoholDao.checkRecordExists(alcoholType: alcoholType)
            if !isExist {
                AlcoholDao.saveAlcoholType(alcoholType: alcoholType, isExist: true)
            }
        }
    }
    
    //Search Bar Logic
    
    private func filterContent(for searchText: String) {
         searchResult = alcoholTypes.filter({ (title: String) -> Bool in
            let match = title.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
    
    private func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    //Checking alcohol in DB and set state of UISwitch
    
    private func checkAvaliableAlcohol(alcoholType: Alcohol! ,alcoholSwitch: UISwitch){
        if alcoholType != nil {
            alcoholSwitch.setOn(alcoholType!.isExist, animated: true)
        } else {
            alcoholSwitch.setOn(true, animated: true)
        }
    }
    
    //Programmaticaly creating switch and switch function
    
    private func createSwitch(alcohol: Alcohol) -> AlcoholUISwitch{
        let createdSwitch = AlcoholUISwitch()
        createdSwitch.alcoholType = alcohol.alcoholType!
        createdSwitch.center = CGPoint(x: 300, y: 30)
        createdSwitch.addTarget(self, action: #selector(switchAction(sender:forEvent:)), for: UIControl.Event.valueChanged)
        createdSwitch.isOn = alcohol.isExist
        self.view.addSubview(createdSwitch)
        return createdSwitch
    }
    
    @objc private func switchAction (sender: UISwitch, forEvent event: UIEvent){
        let alcoholSwitch = sender as? AlcoholUISwitch
        AlcoholDao.saveAlcoholType(alcoholType: alcoholSwitch!.alcoholType , isExist: sender.isOn)
    }
    
    //Programmaticaly creating button
    
    private func createButtonToVeiw(x: Int,y: Int, width: Int, height: Int) -> UIButton {
        let createButton = UIButton()
        createButton.frame = CGRect(x: x, y: y, width: width, height: height)
        self.view.addSubview(createButton)
        return createButton
    }
   
    //Programmaticaly creating label of alcohol
    
    private func createLabelForAlcohol(label: String, x: Int, y: Int, width: Int, height: Int) -> UILabel{
        let createlabel = UILabel()
        createlabel.frame = CGRect(x: x, y: y, width: width, height: height)
        createlabel.textAlignment = .center
        createlabel.text = label
        self.view.addSubview(createlabel)
        return createlabel
    }

    private func setUpNavigationBar() {
        self.navigationItem.title = "Bar"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

