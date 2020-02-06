//
//  NewMeasure.swift
//  PetService
//
//  Created by Dusan Milic on 07/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class NewMeasure: Codable{
    let pet_id: CLong
    let measure: Float
    let time: String
    
    init(pet_id: CLong, measure: Float, time: String){
        self.pet_id = pet_id
        self.measure = measure
        self.time = time
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(pet_id, forKey: "pet_id")
        coder.encode(measure, forKey: "measure")
        coder.encode(time, forKey: "time")
    }
    
    required init?(coder: NSCoder) {
        pet_id = coder.decodeObject(forKey: "pet_id") as! CLong
        measure = coder.decodeObject(forKey: "measure") as! Float
        time = coder.decodeObject(forKey: "time") as! String
    }
}
