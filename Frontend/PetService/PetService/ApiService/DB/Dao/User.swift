//
//  User.swift
//  PetService
//
//  Created by Dusan Milic on 26/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding, Codable{
    
    let id: CLong;
    let full_name: String;
    let email: String;
    let password: String;
    let phoneNumber: String?;
    var firstLogin: Int;
    var dogsOwned: [Dog]?;
    let type: UserType;
    
    init(id: CLong, full_name: String, email: String, password: String, phoneNumber: String? , firstLogin: Int, dogsOwned: [Dog]?, type: UserType) {
        self.id = id;
        self.full_name = full_name;
        self.email = email;
        self.password = password;
        self.phoneNumber = phoneNumber;
        self.firstLogin = firstLogin;
        self.dogsOwned = dogsOwned;
        self.type = type;
    }
    
    init(json: [String : Any]){
        self.id = json["id"] as! CLong;
        self.full_name = json["full_name"] as! String;
        self.email = json["email"] as! String;
        self.password = json["password"] as! String;
        self.phoneNumber = json["phone_number"] as? String;
        self.firstLogin = json["first_login"] as! Int;
        self.dogsOwned = nil;
        self.type = UserType(rawValue: "\(json["user_type"]!)")!
    }
    
    //MARK:- NSCoding protocol
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id");
        aCoder.encode(full_name, forKey: "full_name");
        aCoder.encode(email, forKey: "email");
        aCoder.encode(password, forKey: "password");
        aCoder.encode(dogsOwned, forKey: "dogs");
        aCoder.encode(type, forKey: "UserType");
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(firstLogin, forKey: "firstLogin")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as! CLong;
        full_name = aDecoder.decodeObject(forKey: "full_name") as! String;
        email = aDecoder.decodeObject(forKey: "email") as! String;
        password = aDecoder.decodeObject(forKey: "password") as! String;
        dogsOwned = aDecoder.decodeObject(forKey: "dogs") as? [Dog];
        type = aDecoder.decodeObject(forKey: "UserType") as! UserType;
        phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String;
        firstLogin = aDecoder.decodeObject(forKey: "firstLogin") as! Int;
    }
}
