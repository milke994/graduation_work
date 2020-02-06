//
//  NewAppointment.swift
//  PetService
//
//  Created by Dusan Milic on 08/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class NewAppointment: Codable{
    let vet_id: CLong
    let pet_owner_id: CLong
    let pet_id: CLong
    let date: String
    
    init(vet_id: CLong, pet_owner_id: CLong, pet_id: CLong, date: String){
        self.vet_id = vet_id
        self.pet_owner_id = pet_owner_id
        self.pet_id = pet_id
        self.date = date
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(vet_id, forKey: "vet_id")
        coder.encode(pet_owner_id, forKey: "pet_owner_id")
        coder.encode(pet_id, forKey: "pet_id")
        coder.encode(date, forKey: "date")
    }
    
    required init?(coder: NSCoder) {
        vet_id = coder.decodeObject(forKey: "vet_id") as! CLong
        pet_owner_id = coder.decodeObject(forKey: "pet_owner_id") as! CLong
        pet_id = coder.decodeObject(forKey: "pet_id") as! CLong
        date = coder.decodeObject(forKey: "date") as! String
    }
}
