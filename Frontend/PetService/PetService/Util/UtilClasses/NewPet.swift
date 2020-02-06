//
//  NewPet.swift
//  PetService
//
//  Created by Dusan Milic on 05/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class NewPet: Codable{
    let owner_id: CLong
    let name: String
    let breed: String
    let age: Int
    let weight: Float
    let species: String
    
    init(owner_id: CLong, name: String, species: String, breed: String, age: Int, weight: Float){
        self.owner_id = owner_id
        self.name = name
        self.species = species.uppercased()
        self.breed = breed
        self.age = age
        self.weight = (weight * 100).rounded() / 100
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(owner_id, forKey: "owner_id")
        coder.encode(name, forKey: "name")
        coder.encode(breed, forKey: "breed")
        coder.encode(age, forKey: "age")
        coder.encode(weight, forKey: "weight")
        coder.encode(species, forKey: "species")
    }
    
    required init?(coder: NSCoder) {
        owner_id = coder.decodeObject(forKey: "owner_id") as! CLong
        name = coder.decodeObject(forKey: "name") as! String
        breed = coder.decodeObject(forKey: "breed") as! String
        age = coder.decodeObject(forKey: "age") as! Int
        weight = coder.decodeObject(forKey: "weight") as! Float
        species = coder.decodeObject(forKey: "species") as! String
    }
}
