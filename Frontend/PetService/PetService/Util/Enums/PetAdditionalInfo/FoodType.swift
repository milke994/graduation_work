//
//  FoodType.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation


enum FoodType: String, Codable, CaseIterable{
    case homemade
    case raw
    case semi_moist
    case canned
    case dry
}
