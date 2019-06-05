//
//  HealthKitManager.swift
//  Drinky
//
//  Created by Thijs van der Heijden on 05/06/2019.
//  Copyright © 2019 Thijs van der Heijden. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    private init() {}
    
    static let shared = HealthKitManager()
    
    // method to request user authorization to access and update health data
    func askForHealthKitPermission(completion: @escaping (AppVariables.healthKitStat) -> Void) {
        
        // check if healthkit is available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(AppVariables.healthKitStat.notAvailable)
            return
        }
        
        // Prepare the data types that will interact with HealthKit
        guard let amountOfWaterDrank = HKObjectType.quantityType(forIdentifier: .dietaryWater) else {
                completion(AppVariables.healthKitStat.dataTypeNotAvailable)
                return
        }
        
        // Prepare a list of types you want HealthKit to write
        let healthKitTypesToWrite: Set<HKSampleType> = [amountOfWaterDrank]
        let healthKitTypesToRead: Set<HKSampleType> = [amountOfWaterDrank]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                             read: healthKitTypesToRead) { (success, error) in
                                                if(error != nil) {
                                                    completion(AppVariables.healthKitStat.notAuthorized)
                                                } else if success {
                                                    completion(AppVariables.healthKitStat.authorized)
                                                } else {
                                                    completion(AppVariables.healthKitStat.notAuthorized)
                                                }
        }
    }
    
    // method to add a drink to healthkit
    func addDrinkToHealthkit(ml: Double, date: Date) {
        guard let drinkHealthType = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
            fatalError("Water is no longer a type in HealthKit")
        }
        
        let waterQuantity = HKQuantity(unit: HKUnit.liter(), doubleValue: ml / 1000.0)
        let waterQuantitySample = HKQuantitySample(type: drinkHealthType, quantity: waterQuantity, start: date, end: date)
        
        HKHealthStore().save(waterQuantitySample) { (succes, error) in
            if error != nil {
                print("Error saving drink sample: \(error!.localizedDescription)")
            } else {
                print("Successfully saved drink to health.")
            }
        }
    }
    
    // method to remove the most recent drink from healthkit store
    func removeMostRecentDrink(date: Date) {
        
        let healthStore = HKHealthStore()
        
        // the predicate we want to use to search
        let predicate = HKQuery.predicateForSamples(withStart: date, end: date.addingTimeInterval(TimeInterval(1.0)), options: [])
        
        // the sample type we want to find
        guard let amountOfWaterDrankType = HKObjectType.quantityType(forIdentifier: .dietaryWater) else {
            return
        }
        
        let query = HKSampleQuery(sampleType: amountOfWaterDrankType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {
            query, results, error in
            
            if !(results?.isEmpty ?? true) {
                healthStore.delete(results![0] as HKObject, withCompletion: { (succes, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                    } else if succes {
                        print("succesfully removed sample from healthstore")
                    }
                })
            }
        }
        
        healthStore.execute(query)
    }
}

