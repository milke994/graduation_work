//
//  Credentials.swift
//  PetService
//
//  Created by Dusan Milic on 05/10/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class Credentials:Codable {
    
    var email: String;
    var password: String;
    
    init(email:String, password:String) {
        self.email = email;
        self.password = password;
    }
    
    
}
