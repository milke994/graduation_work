//
//  NewUser.swift
//  PetService
//
//  Created by Dusan Milic on 07/10/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class NewUser:Codable{
    
    var full_name: String;
    var email: String;
    var password: String;
    var user_type: String;
    var first_login: Int;
    var phone_number: String?;
    
    init(fullName: String, email: String, password: String, phoneNumber: String?, type: UserType) {
        self.full_name = fullName;
        self.email = email;
        self.password = password;
        if(type == UserType.VET) {
            self.user_type = "VET";
        } else {
            self.user_type = "PET_OWNER"
        }
        if(phoneNumber == ""){
            self.phone_number = nil;
        } else {
            self.phone_number = phoneNumber;
        }
        self.first_login = 1;
    }
    
    //MARK:- NS CODING PROTOCOL
    func encode(with coder: NSCoder) {
        coder.encode(full_name, forKey: "full_name");
        coder.encode(email, forKey: "email");
        coder.encode(password, forKey: "password");
        coder.encode(user_type, forKey: "User_type");
        coder.encode(phone_number, forKey: "phone_number")
        coder.encode(first_login, forKey: "first_login")
    }
    
    required init?(coder: NSCoder) {
        self.full_name = coder.decodeObject(forKey: "full_name") as! String;
        email = coder.decodeObject(forKey: "email") as! String;
        password = coder.decodeObject(forKey: "password") as! String;
        user_type = coder.decodeObject(forKey: "User_type") as! String;
        phone_number = coder.decodeObject(forKey: "phone_number") as? String;
        first_login = coder.decodeObject(forKey: "first_login") as! Int;
    }
}
