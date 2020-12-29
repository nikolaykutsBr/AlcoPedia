//
//  ViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/26/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let alcoholTypes: [String] = ["Vodka","Gin","Tequila","Triple sec"]
    
    var buttonChangeScreenToCocktails: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateDataBase()
        
        dynamicAlcoholSwitchesCreation()
        self.view.addSubview(scrollView)
        
        
//
//        let gin = AlcoholDao.fetchAlcoholEntity(alcoholType : AlcoholType.GIN)
//        let vodka = AlcoholDao.fetchAlcoholEntity(alcoholType : AlcoholType.VODKA)
//        let tequila = AlcoholDao.fetchAlcoholEntity(alcoholType : AlcoholType.TEQUILA)
//        let tripleSec = AlcoholDao.fetchAlcoholEntity(alcoholType: AlcoholType.TRIPLESEC)
//
//        tripleSecSwitch = createSwitch(x: 250, y: 100)
//        tripleSecSwitch.addTarget(self, action: #selector(self.tripleSecSwitch(_:forEvent:)), for:  UIControl.Event.valueChanged)
//
//
//        checkAvaliableAlcohol(alcoholType: tripleSec, alcoholSwitch: tripleSecSwitch)
//        checkAvaliableAlcohol(alcoholType: gin, alcoholSwitch: ginSwitch)
//        checkAvaliableAlcohol(alcoholType: vodka, alcoholSwitch: vodkaSwitch)
//        checkAvaliableAlcohol(alcoholType: tequila, alcoholSwitch: tequilaSwitch)
//
//        buttonChangeScreenToCocktails = createButtonToVeiw(x: 20, y: 500, width: 120, height: 40)
//        buttonChangeScreenToCocktails.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.003921568627, alpha: 1)
//        buttonChangeScreenToCocktails.setTitle("Igor", for: .normal)
//        buttonChangeScreenToCocktails.setTitle("Kolya", for: .highlighted)
//
//        tripleSecLabel = createLabelForAlcohol(label: "Triple Sec", x: 80, y: 100, width: 100, height: 25)
//
//
     
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dynamicAlcoholSwitchesCreation() {
        
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let alcohols = AlcoholDao.fetchAll()
        var count = 0
        
        for alcohol in alcohols{
            var y = 50*count
            let createdSwitch = createSwitch(alcohol: alcohol, count: count, x: 250, y: y+100)
            count += 1
            let createdLabel = createLabelForAlcohol(label: alcohol.alcoholType!, x: 50, y: y+100, width: 150, height: 25)
            scrollView.addSubview(createdSwitch)
            scrollView.addSubview(createdLabel)

            
            
        }
//        mScrollView.isScrollEnabled = true
//        mScrollView.isUserInteractionEnabled = true
//        
//        let numberOfButtons = 16
//        let numberofRows = 2
//        
//        var count = 0
//        var px = 0
//        var py = 0
//        
//        for _ in 1...numberofRows {
//            px = 0
//            
//            if count < numberOfButtons/2 {
//                for j in 1...numberOfButtons/2 {
//                    count += 1
//                    
//                    let Button = UIButton()
//                    Button.tag = count
//                    Button.frame = CGRect(x: px+10, y: py+10, width: 100, height: 45)
//                    Button.backgroundColor = UIColor.black
//                    Button.setTitle("Hello \(j) ", for: .normal)
//                    Button.addTarget(self, action: #selector(scrollButtonAction), for: .touchUpInside)
//                    mScrollView.addSubview(Button)
//                    px = px + Int(mScrollView.frame.width)/2 - 30
//                }
//            }else{
//                
//                for j in numberOfButtons/2+1...numberOfButtons {
//                    count += 1
//                    
//                    let Button = UIButton()
//                    Button.tag = count
//                    Button.frame = CGRect(x: px+10, y: py+10, width: 100, height: 45)
//                    Button.backgroundColor = UIColor.black
//                    Button.setTitle("Hello \(j) ", for: .normal)
//                    Button.addTarget(self, action: #selector(scrollButtonAction), for: .touchUpInside)
//                    mScrollView.addSubview(Button)
//                    px = px + Int(mScrollView.frame.width)/2 - 30
//                }
//                
//                
//            }
//            
//            py =  Int(mScrollView.frame.height)-70
//        }
//        
//        mScrollView.contentSize = CGSize(width: px, height: py)
//        
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
    
    func createSwitch(alcohol: Alcohol, count: Int, x: Int, y: Int) -> AlcoholUISwitch{
        let createdSwitch = AlcoholUISwitch()
        createdSwitch.tag = count
        createdSwitch.alcoholType = alcohol.alcoholType!
        createdSwitch.frame = CGRect(x: x, y: y, width: 0, height: 0)
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

