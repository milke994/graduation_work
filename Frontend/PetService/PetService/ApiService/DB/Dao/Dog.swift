//
//  Dog.swift
//  PetService
//
//  Created by Dusan Milic on 25/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation
import UIKit

class Dog : NSObject, NSCoding, Codable{
    
    let id: CLong
    let ownerId: CLong
    let name: String;
    let yearOfBirth: Int;
    let species: String;
    let breed: String;
    let genre: String;
    let weight: Float;
    var additionalInfo: PetAdditionalInfo?
    var medicalInfo: MedicalFile?
    var picture: Picture?;
    
    init(id: CLong, ownerId: CLong, name: String, yearOfBirth: Int, species: String, breed: String, genre: String, weight: Float, picture: Picture?) {
        self.id = id
        self.ownerId = ownerId
        self.name = name;
        self.yearOfBirth = yearOfBirth;
        self.species = species;
        self.breed = breed;
        self.genre = genre;
        self.weight = weight;
        self.picture = picture;
        self.additionalInfo = nil
        self.medicalInfo = nil
    }
    
    init(json: [String : Any]){
        self.id = json["id"] as! CLong;
        let user = User(json: json["owner"] as! [String: Any])
        self.ownerId = user.id
        self.name = json["name"] as! String
        self.yearOfBirth = json["age"] as! Int
        self.species = (json["species"] as! String).lowercased()
        self.breed = json["breed"] as! String
        self.genre = "Male"
        self.weight = (json["weight"] as! NSNumber).floatValue
        let photoJson = json["photo"] as? [String: Any]
        if(photoJson != nil){
            self.picture = Picture(json: photoJson!)
        }
        let addInfo: [String:Any]? = json["pet_info"] as? [String: Any]
        if(addInfo != nil){
            self.additionalInfo = PetAdditionalInfo(json: addInfo!, pet_id: self.id)
        }
        let medInfo: [String: Any]? = json["medical_info"] as? [String: Any]
        if(medInfo != nil){
            self.medicalInfo = MedicalFile(json: medInfo!)
        }
    }
    
    //MARK:- NSCoding protocol
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(ownerId, forKey: "ownerId")
        aCoder.encode(name, forKey: "name");
        aCoder.encode(yearOfBirth, forKey: "yearOfBirth");
        aCoder.encode(species, forKey: "species");
        aCoder.encode(breed, forKey: "breed");
        aCoder.encode(genre, forKey: "genre");
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(picture, forKey: "picture");
        aCoder.encode(additionalInfo, forKey: "additionalInfo")
        aCoder.encode(medicalInfo, forKey: "medicalInfo")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as! CLong
        ownerId = aDecoder.decodeObject(forKey: "ownerId") as! CLong
        name = aDecoder.decodeObject(forKey: "name") as! String;
        yearOfBirth = aDecoder.decodeObject(forKey: "yearOfBirth") as! Int;
        species = aDecoder.decodeObject(forKey: "species") as! String;
        breed = aDecoder.decodeObject(forKey: "breed") as! String;
        genre = aDecoder.decodeObject(forKey: "genre") as! String;
        weight = aDecoder.decodeObject(forKey: "weight") as! Float;
        picture = aDecoder.decodeObject(forKey: "picture") as? Picture;
        additionalInfo = aDecoder.decodeObject(forKey: "additionalInfo") as? PetAdditionalInfo
        medicalInfo = aDecoder.decodeObject(forKey: "medicalInfo") as? MedicalFile
    }
}
