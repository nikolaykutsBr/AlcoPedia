//
//  Alcohol+CoreDataProperties.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/26/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//
//

import Foundation
import CoreData


extension Alcohol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alcohol> {
        return NSFetchRequest<Alcohol>(entityName: "Alcohol")
    }

    @NSManaged public var alcoholType: String?
    @NSManaged public var isExist: Bool

}
