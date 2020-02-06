//
//  MedicalFile.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class MedicalFile: NSObject, NSCoding, Codable{
    
    let pet_id: CLong
    let diseases: String?
    let allergies: String?
    let treatments: String?
    
    init(id: CLong, diseases: String?, allergies: String?, treatments: String?){
        self.pet_id = id
        self.diseases = diseases
        self.allergies = allergies
        self.treatments = treatments
    }
    
    init(json: [String : Any]){
        self.pet_id = json["id"] as! CLong
        self.diseases = json["diseases"] as? String
        self.allergies = json["allergies"] as? String
        self.treatments = json["treatments"] as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.pet_id, forKey: "id")
        coder.encode(self.diseases, forKey: "diseases")
        coder.encode(self.allergies, forKey: "allergies")
        coder.encode(self.treatments, forKey: "treatments")
    }
    
    required init?(coder: NSCoder) {
        self.pet_id = coder.decodeObject(forKey: "pet_id") as! CLong
        self.diseases = coder.decodeObject(forKey: "diseases") as? String
        self.allergies = coder.decodeObject(forKey: "allergies") as? String
        self.treatments = coder.decodeObject(forKey: "treatments") as? String
    }
}
