//
//  DateRange.swift
//  PetService
//
//  Created by Dusan Milic on 08/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class DateRange: Codable{
    let date_from: String
    let date_to: String
    
    init(date_from: String, date_to: String){
        self.date_from = date_from
        self.date_to = date_to
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(date_from, forKey: "date_from")
        coder.encode(date_to, forKey: "date_to")
    }
    
    required init?(coder: NSCoder) {
        date_from = coder.decodeObject(forKey: "date_from") as! String
        date_to = coder.decodeObject(forKey: "date_to") as! String
    }
}
