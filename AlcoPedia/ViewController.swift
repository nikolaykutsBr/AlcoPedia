//
//  ViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/26/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var vodkaSwitch: UISwitch!
    @IBOutlet weak var tequilaSwitch: UISwitch!
    @IBOutlet weak var ginSwitch: UISwitch!
    
    @IBAction func vodkaSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        AlcoholDao.saveAlcoholType(alcoholType: AlcoholType.VODKA, isExist: sender.isOn)
    }
    @IBAction func tequilaSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        AlcoholDao.saveAlcoholType(alcoholType: AlcoholType.TEQUILA, isExist: sender.isOn)
    }
    
    @IBAction func ginSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
        AlcoholDao.saveAlcoholType(alcoholType: AlcoholType.GIN, isExist: sender.isOn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gin = AlcoholDao.fetchAlcoholEntity(alcoholType : AlcoholType.GIN)
        
        if gin != nil {
            ginSwitch.setOn(gin!.isExist, animated: true)
        } else {
           ginSwitch.setOn(true, animated: true)
        }
        
        let vodka = AlcoholDao.fetchAlcoholEntity(alcoholType : AlcoholType.VODKA)
        
        if vodka != nil {
            vodkaSwitch.setOn(vodka!.isExist, animated: true)
        } else {
            vodkaSwitch.setOn(true, animated: true)
        }
        
        let tequila = AlcoholDao.fetchAlcoholEntity(alcoholType : AlcoholType.TEQUILA)
        
        if tequila != nil {
            tequilaSwitch.setOn(tequila!.isExist, animated: true)
        } else {
            tequilaSwitch.setOn(true, animated: true)
        }
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

