//
//  NSPersistentContainer.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 30/05/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//
import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.eu.thijsvanderheijden.Drinky")
        storeURL = storeURL?.appendingPathComponent("Drinky.sqlite")
        return storeURL!
    }
    
}
