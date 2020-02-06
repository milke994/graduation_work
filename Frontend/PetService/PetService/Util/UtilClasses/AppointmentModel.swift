//
//  AppointmentModel.swift
//  PetService
//
//  Created by Dusan Milic on 08/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class AppoinmentModel: Codable{
    let id: CLong
    let vet: User
    let pet_owner: User
    let pet: Dog
    var appointment_status: AppointmentStatus
    let time: String
    
    init(id:CLong, vet: User, pet_owner: User, pet: Dog, appointment_status: AppointmentStatus, time: String){
        self.id = id
        self.vet = vet
        self.pet_owner = pet_owner
        self.pet = pet
        self.appointment_status = appointment_status
        self.time = time
    }
    
    init(json: [String: Any]){
        id = json["id"] as! CLong
        vet = User(json: json["vet"] as! [String: Any])
        pet_owner = User(json: json["pet_owner"] as! [String: Any])
        pet = Dog(json: json["pet"] as! [String: Any])
        appointment_status = AppointmentStatus(rawValue: json["appointment_status"] as! String)!
        let components: [String] = (json["time"] as! String).components(separatedBy: "T")
        self.time = components[0] + " " + components[1]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id , forKey: "id")
        coder.encode(vet, forKey: "vet")
        coder.encode(pet_owner, forKey: "pet_owner")
        coder.encode(pet, forKey: "pet")
        coder.encode(appointment_status, forKey: "appointment_status")
        coder.encode(time, forKey: "time")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as! CLong
        vet = coder.decodeObject(forKey: "vet") as! User
        pet_owner = coder.decodeObject(forKey: "pet_owner") as! User
        pet = coder.decodeObject(forKey: "pet") as! Dog
        appointment_status = coder.decodeObject(forKey: "appointment_status") as! AppointmentStatus
        time = coder.decodeObject(forKey: "time") as! String
    }

}
