//
//  System.swift
//  PetService
//
//  Created by Dusan Milic on 08/10/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class System {

    // MARK: - Properties

    private static var sharedSystem: System = {
        let system = System()
        return system
    }()

    // MARK: - variables

    private var logedInUser: User?;
    private var activeDog: Dog?;
    private var petsOwned: [Dog]?;

    // Initialization

    private init() {
        self.logedInUser = nil;
        self.activeDog = nil;
        self.petsOwned = nil;
    }
    
    public func setLogedInUser(user: User){
        self.logedInUser = user;
    }
    
    public func setActiveDog(dog: Dog){
        self.activeDog = dog;
    }
    
    public func setPetsOwned(pets: [Dog]){
        self.petsOwned = pets;
    }
    
    public func getLogedInUser() -> User?{
        return self.logedInUser;
    }
    
    public func getActiveDog()-> Dog?{
        return self.activeDog;
    }
    
    public func getPetsOwned()-> [Dog]?{
        return self.petsOwned;
    }

    // MARK: - Accessors

    class func shared() -> System {
        return sharedSystem
    }

}
