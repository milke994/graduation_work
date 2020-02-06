//
//  PetAdditionalInfo.swift
//  PetService
//
//  Created by Dusan Milic on 02/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation

class PetAdditionalInfo: NSObject, NSCoding, Codable{
    
    var pet_id : CLong
    var indoor: Indoor_Outdoor?
    var food_type: FoodType?
    var meal_size: MealSize?
    var meals_per_day: Int?
    var physical_activity: PhysicalActivity?
    var traveling: Traveling?
    
    init(id: CLong, indoor: Indoor_Outdoor?, foodType: FoodType?, mealSize: MealSize?, mealsPerDay: Int?, physicalActivity: PhysicalActivity?, traveling: Traveling?){
        self.pet_id = id
        self.indoor = indoor
        self.food_type = foodType
        self.meal_size = mealSize
        self.meals_per_day = mealsPerDay
        self.physical_activity = physicalActivity
        self.traveling = traveling
    }
    
    static func giveValue(destination: Any?, value: String?)->Any?{
        if(value != nil){
            if(value != nil){
                switch destination {
                case is Indoor_Outdoor:
                    return Indoor_Outdoor(rawValue: value!)
                case is FoodType:
                    return FoodType(rawValue: value!)
                case is MealSize:
                    return MealSize(rawValue: value!)
                case is PhysicalActivity:
                    return PhysicalActivity(rawValue: value!)
                case is Traveling:
                    return Traveling(rawValue: value!)
                default:
                    break
                }
            }
        }
        return nil
    }
    
    init(json: [String : Any], pet_id: CLong){
        self.pet_id = pet_id
        self.indoor = Indoor_Outdoor(rawValue: json["indoor"] as! String)
        self.food_type = FoodType(rawValue: json["food_type"] as! String)
        self.meal_size = MealSize(rawValue: json["meal_size"] as! String)
        self.physical_activity = PhysicalActivity(rawValue: json["physical_activity"] as! String)
        self.traveling = Traveling(rawValue: json["traveling"] as! String)
        self.meals_per_day = json["meals_per_day"] as? Int
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(pet_id, forKey: "petId")
        coder.encode(indoor, forKey: "indoor/outdoor")
        coder.encode(food_type, forKey: "foodType")
        coder.encode(meal_size, forKey: "mealSize")
        coder.encode(meals_per_day, forKey: "mealsPerDay")
        coder.encode(physical_activity, forKey: "physicalActivity")
        coder.encode(traveling, forKey: "traveling")
    }
    
    required init?(coder: NSCoder) {
        self.pet_id = coder.decodeObject(forKey: "petId") as! CLong
        self.indoor = coder.decodeObject(forKey: "indoor/outdoor") as? Indoor_Outdoor
        self.food_type = coder.decodeObject(forKey: "foodType") as? FoodType
        self.meal_size = coder.decodeObject(forKey: "mealSize") as? MealSize
        self.meals_per_day = coder.decodeObject(forKey: "mealsPerDay") as? Int
        self.physical_activity = coder.decodeObject(forKey: "physicalActivity") as? PhysicalActivity
        self.traveling = coder.decodeObject(forKey: "traveling") as? Traveling
    }
    
    
}
