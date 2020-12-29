//
//  Cockatail+CoreDataProperties.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/29/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//
//

import Foundation
import CoreData


extension Cockatail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cockatail> {
        return NSFetchRequest<Cockatail>(entityName: "Cockatail")
    }

    @NSManaged public var nameCocktail: String?

}
