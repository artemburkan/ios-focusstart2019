//
//  CarStorage.swift
//  CarCatalog
//
//  Created by Artyom Burkan on 28/04/2019.
//  Copyright © 2019 Artyom Burkan. All rights reserved.
//

import Foundation

class CarStorage: NSObject {
    static let shared = CarStorage()
    private var userDefaults = UserDefaults.standard
    
    override init() {
        super.init()
        firstInitiate()
    }
    
    
    var carList: [Car] {
        set {
            guard let encodedData: Data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) else {
                return
            }
            
            userDefaults.set(encodedData, forKey: "carList")
            userDefaults.synchronize()
        }
        
        get {
            guard let data = userDefaults.data(forKey: "carList"),
                let carList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Car] else { return[] }

            
            return carList
        }
    }
    
    private func firstInitiate() {
        if !userDefaults.bool(forKey: "firstInitiate") {
            userDefaults.set(true, forKey: "firstInitiate")

            let firstCarList = [
                Car(releaseYear: "1995", model: "model", producer: "producer", classType: "classType", bodyType: "bodyType"),
                Car(releaseYear: "1995", model: "model", producer: "producer", classType: "classType", bodyType: "bodyType"),
                Car(releaseYear: "1995", model: "model", producer: "producer", classType: "classType", bodyType: "bodyType")
            ]
            
            carList = firstCarList
        }
    }
    
    func add(car: Car) {
        var currentCarList = carList
        currentCarList.append(car)
        carList = currentCarList
    }
    
    func remove(index: Int) {
        var currentCarList = carList
        currentCarList.remove(at: index)
        carList = currentCarList
    }
    
    func edit(car: Car, index: Int) {
        var currentCarList = carList
        currentCarList[index] = car
        carList = currentCarList
    }
}
