//
//  SpeciesRow.swift
//  PetService
//
//  Created by Dusan Milic on 13/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class DropdownRow : SwiftyMenuDisplayable{
    var displayableValue: String
    
    var retrivableValue: Any
    
    init(displayableValue: String, retrivableValue: Any) {
        self.displayableValue = displayableValue;
        self.retrivableValue = retrivableValue;
    }
    
}
