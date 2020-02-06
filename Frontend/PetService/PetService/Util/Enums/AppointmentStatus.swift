//
//  AppointmentStatus.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

enum AppointmentStatus: String, Codable, CaseIterable{
    case WAITING
    case CONFIRMED
    case REJECTED
}
