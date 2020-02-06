//
//  PhysicalActivity.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

enum PhysicalActivity: String, Codable, CaseIterable{
    case no_activity
    case light
    case medium
    case active
    case training_dog
}
