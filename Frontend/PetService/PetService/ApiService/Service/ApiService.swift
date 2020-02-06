//
//  ApiService.swift
//  PetService
//
//  Created by Dusan Milic on 30/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    func login(username: String, password: String, completion: @escaping (Int) -> ()){
        let credentials = Credentials(email: username, password: password)
        guard let uploadData = try? JSONEncoder().encode(credentials) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/users/credentials")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var logedIn: Int = 0
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                logedIn = 1
                DispatchQueue.main.async(execute: {
                    completion(logedIn)
                })
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                logedIn = 2
                DispatchQueue.main.async(execute: {
                    completion(logedIn)
                })
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                logedIn = 3
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
                System.shared().setLogedInUser(user: User(json: json))
                DispatchQueue.main.async(execute: {
                    completion(logedIn)
                })
            }
        }
        task.resume()
    }
    
    func changeFirstLogedIn(){
        let url = URL(string: "http://localhost.local:8080/v1/users/logedIn/\(System.shared().getLogedInUser()!.id)")!
        
        let task = URLSession.shared.dataTask(with: url)
        
        task.resume()
    }
    
    func getAllVets(completion: @escaping ([User]?) -> ()){
        let url = URL(string: "http://localhost.local:8080/v1/users/\(UserType.VET)")!
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            do {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var vets: [User]?
                
                for dictionary in json as! [[String: AnyObject]]{
                    if(vets == nil){
                        vets = [User]()
                    }
                    vets!.append(User(json: dictionary))
                }
                DispatchQueue.main.async {
                    completion(vets)
                }
            }
        }
        task.resume()
    }
    
    func register(fullName: String, email:String, password: String, phoneNumber: String, userType: UserType, completion: @escaping ()->()){
        let newUser = NewUser(fullName: fullName, email: email, password: password, phoneNumber: phoneNumber, type: userType);
        guard let uploadData = try? JSONEncoder().encode(newUser) else {
            return
        }
//        let dataString = String(data: uploadData, encoding: .utf8)!
        let url = URL(string: "http://localhost.local:8080/v1/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
                DispatchQueue.main.async(execute: {
                    completion()
                })
            }
        }
        task.resume();
    }
    
    func createPet(newPet: NewPet, completion: @escaping (Dog)->()){
        guard let uploadData = try? JSONEncoder().encode(newPet) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/pets")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
                let pet = Dog(json: json)
                
                DispatchQueue.main.async(execute: {
                    completion(pet)
                })
            }
        }
        task.resume();
    }
    
    func setProfileImage(picture: NewPicture, completion: @escaping (CLong)->()){
        guard let uploadData = try? JSONEncoder().encode(picture) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/photos/profile")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
                let pictureId: CLong = json["pet_profile_picture"] as! CLong
                DispatchQueue.main.async(execute: {
                    completion(pictureId)
                })
            }
        }
        task.resume();
    }
    
    func addImage(newImage: NewPicture, completion: @escaping (Picture)->()){
        guard let uploadData = try? JSONEncoder().encode(newImage) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/photos/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
                let picture = Picture(json: json)
                DispatchQueue.main.async(execute: {
                    completion(picture)
                })
            }
        }
        task.resume();
    }
    
    func getAllPetOwners(completion: @escaping ([User]?) -> ()){
        let url = URL(string: "http://localhost.local:8080/v1/users/\(UserType.PET_OWNER)")!
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            do {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var owners: [User]?
                
                for dictionary in json as! [[String: AnyObject]]{
                    if(owners == nil){
                        owners = [User]()
                    }
                    owners!.append(User(json: dictionary))
                }
                DispatchQueue.main.async {
                    completion(owners)
                }
            }
        }
        task.resume()
    }
    
    func getAllPetsForOwner(id: CLong, completion: @escaping([Dog]?, [CLong]?)->()){
        let url = URL(string: "http://localhost.local:8080/v1/pets/owner/\(id)")!
        var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print ("error: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
                }
                if let mimeType = response.mimeType,
                    mimeType == "application/json",
                    let data = data {
    
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    var pets: [Dog]?
                    var photoIDs: [CLong]?
                    
                    for dictionary in json as! [[String: AnyObject]]{
                        if(pets == nil){
                            pets = [Dog]()
                            photoIDs = [CLong]()
                        }
                        let dog: Dog = Dog(json: dictionary)
                        pets!.append(dog)
                        photoIDs!.append(dictionary["pet_profile_picture"] as! CLong)
                        
                    }
                    DispatchQueue.main.async(execute: {
                        completion(pets, photoIDs)
                    })
                    
                    
                }
            }
            task.resume();
        }
    
    func getProfilePicture(id: CLong, completion: @escaping(Picture?)->()){
        let url = URL(string: "http://localhost.local:8080/v1/photos/\(id)")!
            var request: URLRequest = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print ("error: \(error)")
                        return
                    }
                    guard let response = response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                        print ("server error")
                        return
                    }
                    if let mimeType = response.mimeType,
                        mimeType == "application/json",
                        let data = data {
        
                        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        
                        let photo: Picture = Picture(json: json as! [String: Any])
                        
                        DispatchQueue.main.async(execute: {
                            completion(photo)
                        })
                    }
                }
            task.resume();
        }
    
    func getAllImagesForPet(petId: CLong, completion: @escaping([Picture]?)->()){
        let url = URL(string: "http://localhost.local:8080/v1/photos/pets/\(petId)")!
            var request: URLRequest = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print ("error: \(error)")
                        return
                    }
                    guard let response = response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                        print ("server error")
                        return
                    }
                    if let mimeType = response.mimeType,
                        mimeType == "application/json",
                        let data = data {
        
                        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        
                        var pictures: [Picture]?
                        
                        for dictionary in json as! [[String: AnyObject]]{
                            if(pictures == nil){
                                pictures = [Picture]()
                            }
                            pictures!.append(Picture(json: dictionary))
                        }
                        
                        DispatchQueue.main.async(execute: {
                            completion(pictures)
                        })
                    }
                }
            task.resume();
    }
    
    func savePetInfo(){
        guard let uploadData = try? JSONEncoder().encode(System.shared().getActiveDog()!.additionalInfo) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/pets/pet_info/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
            }
        }
        task.resume();
    }
    
    func createMeasurement(measure: NewMeasure){
        guard let uploadData = try? JSONEncoder().encode(measure) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/measurements")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
            }
        }
        task.resume();
    }
    
    func getMeasurementsForPet(petId: CLong, completion: @escaping([Measurement]?)->()){
        let url = URL(string: "http://localhost.local:8080/v1/measurements/\(petId)")!
            var request: URLRequest = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print ("error: \(error)")
                        return
                    }
                    guard let response = response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                        print ("server error")
                        return
                    }
                    if let mimeType = response.mimeType,
                        mimeType == "application/json",
                        let data = data {
        
                        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        var measures: [Measurement]?
                        
                        for dictionary in json as! [[String: AnyObject]]{
                            if(measures == nil){
                                measures = [Measurement]()
                            }
                            measures!.append(Measurement(json: dictionary))
                        }
                        
                        
                        DispatchQueue.main.async(execute: {
                            completion(measures)
                        })
                    }
                }
            task.resume();
    }
    
    func createAppoinment(appointment: NewAppointment, completion: @escaping ()->()){
        guard let uploadData = try? JSONEncoder().encode(appointment) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/appointments")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                    return;
                }
                DispatchQueue.main.async(execute: {
                    completion()
                })
            }
        }
        task.resume();
    }
    
    func getAppointmentsForVetAndDate(dateRange: DateRange, vetId: CLong, completion: @escaping ([AppoinmentModel]?)->()){
        guard let uploadData = try? JSONEncoder().encode(dateRange) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/appointments/\(vetId)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                var appointments: [AppoinmentModel]?
                for dictionary in json as! [[String: AnyObject]]{
                    if(appointments == nil){
                        appointments = [AppoinmentModel]()
                    }
                    appointments!.append(AppoinmentModel(json: dictionary))
                }
                
                DispatchQueue.main.async(execute: {
                    completion(appointments)
                })
            }
        }
        task.resume();
    }
    
    func createMedicalInfo(medicalFile: MedicalFile){
        guard let uploadData = try? JSONEncoder().encode(medicalFile) else {
            return
        }
        let url = URL(string: "http://localhost.local:8080/v1/pets/medical_info/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            }
        }
        task.resume();
    }
}

