//
//  SwitchCreating.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/28/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import Foundation
import UIKit

class SwitchCreating: UIViewController {
    
    func createSwitch(uiswitch: UISwitch, x: Int, y: Int) -> UISwitch{
        let createSwitch = uiswitch
        createSwitch.frame = CGRect(x: x, y: y, width: 0, height: 0)
        view.addSubview(createSwitch)
        return createSwitch
    }
    
    
    
}
