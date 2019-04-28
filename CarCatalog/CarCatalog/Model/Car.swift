//
//  Car.swift
//  CarCatalog
//
//  Created by Artyom Burkan on 28/04/2019.
//  Copyright © 2019 Artyom Burkan. All rights reserved.
//

import Foundation

class Car: NSObject, NSCoding {
    var releaseYear: String
    var model: String
    var producer: String
    var classType: String
    var bodyType: String
    
    init(releaseYear: String,
        model: String,
        producer: String,
        classType: String,
        bodyType: String
    ) {
        self.releaseYear = releaseYear
        self.model = model
        self.producer = producer
        self.classType = classType
        self.bodyType = bodyType
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let releaseYear = aDecoder.decodeObject(forKey: "releaseYear") as? String
        let model = aDecoder.decodeObject(forKey: "model") as? String
        let producer = aDecoder.decodeObject(forKey: "producer") as? String
        let classType = aDecoder.decodeObject(forKey: "classType") as? String
        let bodyType = aDecoder.decodeObject(forKey: "bodyType") as? String
        
        self.init(releaseYear: releaseYear ?? "",
                  model: model ?? "",
                  producer: producer ?? "",
                  classType: classType ?? "",
                  bodyType: bodyType ?? "")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(releaseYear, forKey: "releaseYear")
        aCoder.encode(model, forKey: "model")
        aCoder.encode(producer, forKey: "producer")
        aCoder.encode(classType, forKey: "classType")
        aCoder.encode(bodyType, forKey: "bodyType")
    }
}
