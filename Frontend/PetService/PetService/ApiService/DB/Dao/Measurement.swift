//
//  Measurement.swift
//  PetService
//
//  Created by Dusan Milic on 21/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

public class Measurement{
    var measure: Float
    var time: String
    
    init(measure: Float, date: String) {
        self.measure = measure
        self.time = date
    }
    
    init(json: [String: Any]){
        self.measure = (json["measure"] as! NSNumber).floatValue
        self.time = (json["time"] as! String).substring(to: (json["time"] as! String).index(of: "T")!)
    }
}
