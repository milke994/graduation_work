//
//  Picture.swift
//  PetService
//
//  Created by Dusan Milic on 05/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class Picture: NSObject, NSCoding, Codable {
    var id: CLong
    let pet_id: CLong
    var photo: Data
    
    init(id: CLong, petId: CLong, image: String){
        self.id = id
        self.pet_id = petId
        self.photo = image.toImage()!.pngData()!
    }
    
    init(json: [String: Any]){
        self.id = json["id"] as! CLong
        self.pet_id = json["pet_id"] as! CLong
        if((json["photo"] as! String).toImage() != nil){
            self.photo = (json["photo"] as! String).toImage()!.pngData()!
        } else {
            photo = Data()
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(pet_id, forKey: "pet_id")
        coder.encode(photo, forKey: "photo")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as! CLong
        pet_id = coder.decodeObject(forKey: "pet_id") as! CLong
        photo = coder.decodeObject(forKey: "photo") as! Data
    }
}
