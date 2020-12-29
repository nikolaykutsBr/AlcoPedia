//
//  AlcoholSwitch.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/30/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import Foundation
import UIKit

class AlcoholUISwitch: UISwitch {
    var alcoholType: String
    
    override init(frame: CGRect) {
        alcoholType = ""
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
