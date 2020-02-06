//
//  Appointment.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class Appointment: NSObject, NSCoding, Codable{
    
    let vetId: CLong
    let petId: CLong
    let petOwnerId: CLong
    var status: AppointmentStatus
    let date: Date
    
    init(vetId: CLong, petId: CLong, petOwnerId: CLong, date: Date){
        self.vetId = vetId
        self.petId = petId
        self.petOwnerId = petOwnerId
        self.status = AppointmentStatus.WAITING
        self.date = date
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.vetId, forKey: "vetId")
        coder.encode(self.petId, forKey: "petId")
        coder.encode(self.petOwnerId, forKey: "petOwnerId")
        coder.encode(self.status, forKey: "status")
        coder.encode(self.date, forKey: "date")
    }
    
    required init?(coder: NSCoder) {
        self.vetId = coder.decodeObject(forKey: "vetId") as! CLong
        self.petId = coder.decodeObject(forKey: "petId") as! CLong
        self.petOwnerId = coder.decodeObject(forKey: "petOwnerId") as! CLong
        self.status = coder.decodeObject(forKey: "status") as! AppointmentStatus
        self.date = coder.decodeObject(forKey: "date") as! Date
    }
}
