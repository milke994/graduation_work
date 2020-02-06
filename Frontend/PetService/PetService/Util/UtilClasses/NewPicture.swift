//
//  File.swift
//  PetService
//
//  Created by Dusan Milic on 05/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class NewPicture: Codable{
    let pet_id: CLong
    var photo: String
    
    init(petId: CLong, picture: String){
        self.pet_id = petId
        self.photo = picture
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(pet_id, forKey: "pet_id")
        coder.encode(photo, forKey: "photo")
    }
    
    required init?(coder: NSCoder) {
        pet_id = coder.decodeObject(forKey: "pet_id") as! CLong
        photo = coder.decodeObject(forKey: "photo") as! String
    }
}
