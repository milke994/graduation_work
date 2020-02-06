//
//  MealSize.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

enum MealSize: String, Codable, CaseIterable{
    case diet
    case light
    case medium
    case big
    case overeating
}
