//
//  AlcoholDao.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/26/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AlcoholDao{
    
    private static func setContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }
    
    static func saveAlcoholType(alcoholType: AlcoholType, isExist: Bool){
        let context = setContext()
        let alcohol: Alcohol! = fetchAlcoholEntity(alcoholType: alcoholType)
        
        if alcohol != nil{
            alcohol.alcoholType = String(describing: alcoholType)
            alcohol.isExist = isExist
        }else{
            let newAlcohol = Alcohol(context: context)
            newAlcohol.alcoholType = String(describing: alcoholType)
            newAlcohol.isExist = isExist
        }
        
        do
        {
            try context.save()
            print("Alcohol updated")
        }
        catch { fatalError("Unable to save data.") }
    }
    
    static func fetchAlcoholEntity(alcoholType: AlcoholType) -> Alcohol! {
        let context = setContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Alcohol")
        
        request.predicate = NSPredicate(format: "alcoholType = %@", String(describing: alcoholType))
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let actualResult = result as! [Alcohol]
           
            return actualResult.isEmpty ? nil : actualResult[0]
        } catch {
            print("Failed to fetch alcoholEntity with following type \(alcoholType)")
            return nil
        }
        
    }
    
//    static func fetchAll() {
//        let context = setContext()
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Alcohol")
//        
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            let actualResult = result as! [Alcohol]
//            
//        } catch {
//            print("Failed to fetch alcoholEntity with following type")
//        
//        }
//    }
}
