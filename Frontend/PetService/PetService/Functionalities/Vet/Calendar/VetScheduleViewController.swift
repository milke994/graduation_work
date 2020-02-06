//
//  VetScheduleViewController.swift
//  PetService
//
//  Created by Dusan Milic on 08/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class VetScheduleViewController: UIViewController, vetAppointmentScheduleProtocol, SwiftyMenuDelegate {
    
    @IBOutlet weak var vetsDropdownList: SwiftyMenu!
    @IBOutlet weak var petsDropdownList: SwiftyMenu!
    @IBOutlet weak var dateLabel: UILabel!
    var dateSelected: Date?
    
    var petOwners: [User]?
    var pets: [Dog]?
    
    var selectedOwner: User?
    var selectedPet: Dog?
    
    var delegate: AppointmentInsertedProtocol?
    
    var petOwnersOptionalData: [SwiftyMenuDisplayable] = []
    var petOptionalData: [SwiftyMenuDisplayable] = []
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.setDropDownParameters(dropDown: self.vetsDropdownList, placeholder: "Choose owner")
        self.setDropDownParameters(dropDown: self.petsDropdownList, placeholder: "Choose Pet")
        
        self.setupDateFormatter()
        
        
        self.dateLabel.text = self.dateFormatter.string(from: self.dateSelected!)
//        self.dateLabel.text = "\(self.dateSelected!)"
        
        ApiService.sharedInstance.getAllPetOwners { (owners: [User]?) in
            if(owners != nil){
                self.petOwners = owners
                self.setData(dropdownList: self.vetsDropdownList)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func setupDateFormatter(){
    //        self.dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
            self.dateFormatter.dateStyle = .medium
            self.dateFormatter.timeStyle = DateFormatter.Style.medium
        }
    
    func setDropDownParameters(dropDown: SwiftyMenu, placeholder: String) {
        dropDown.placeHolderText = placeholder
        dropDown.arrow = UIImage(named: "Disclosure_Arrow_1");
        dropDown.delegate = self;
        
        dropDown.listHeight = 150
        dropDown.borderColor = .black
        dropDown.placeHolderColor = .blue
        dropDown.hideOptionsWhenSelect = true;
        
        dropDown.expandingAnimationStyle = .linear
        dropDown.expandingDuration = 0.5
        dropDown.collapsingAnimationStyle = .linear
        dropDown.collapsingDuration = 0.5
    }
    
    func setData(dropdownList: SwiftyMenu){
        if(dropdownList == vetsDropdownList){
            self.petOwnersOptionalData.removeAll()
            for owner in petOwners!{
                self.petOwnersOptionalData.append(DropdownRow(displayableValue: owner.full_name, retrivableValue: owner))
            }
            self.vetsDropdownList.options = petOwnersOptionalData
        } else {
            self.petOptionalData.removeAll()
            for pet in pets!{
                self.petOptionalData.append(DropdownRow(displayableValue: pet.name, retrivableValue: pet))
            }
            self.petsDropdownList.options = self.petOptionalData
            self.petsDropdownList.selectedIndex = nil
            self.petsDropdownList.placeHolderColor = .blue
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Selection error",
                                                     message: "You must select the pet you want!",
                                                     preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default,
                                                  handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func scheduleButtonClicked(_ sender: Any) {
        if(self.selectedPet == nil || self.selectedOwner == nil){
            self.showAlert()
        } else{
            let appointment: NewAppointment = NewAppointment(vet_id: System.shared().getLogedInUser()!.id, pet_owner_id: self.selectedOwner!.id, pet_id: self.selectedPet!.id, date: "\(self.dateSelected!)")
            
            ApiService.sharedInstance.createAppoinment(appointment: appointment, completion: {
                
            })
            self.delegate?.appointmentInserted()
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func selected(date: Date) {
        self.dateSelected = date
        print(self.dateSelected!)
    }
    
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        if(swiftyMenu == self.vetsDropdownList){
            self.selectedPet = nil
            self.selectedOwner = selectedOption.retrivableValue as? User
            ApiService.sharedInstance.getAllPetsForOwner(id: self.selectedOwner!.id) { (pets: [Dog]?, imageIds: [CLong]?) in
                self.pets = pets
                self.setData(dropdownList: self.petsDropdownList)
            }
        }else{
            self.selectedPet = selectedOption.retrivableValue as? Dog
        }
    }
    

    
}
