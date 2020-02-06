//
//  SelectPetViewController.swift
//  PetService
//
//  Created by Dusan Milic on 04/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol petSelectedProtocol {
    func petSelected(pet: Dog, imageId: CLong)
}

class SelectPetViewController: UIViewController, SwiftyMenuDelegate {
    

    
    @IBOutlet weak var selectPetOwnerDropdownList: SwiftyMenu!
    @IBOutlet weak var selectPetDropdownList: SwiftyMenu!
    
    var petOwnerOptionalData: [SwiftyMenuDisplayable] = []
    var petOptionalData: [SwiftyMenuDisplayable] = []
    
    var petOwners: [User]?
    var pets: [Dog]?
    var imageIds: [CLong]?
    var selectedPet: Dog?
    var selectedPetImageId: CLong?
    var delegate: petSelectedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPetOwnerDropdownList.delegate = self
        selectPetDropdownList.delegate = self
        
        self.setDropDownParameters(dropDown: self.selectPetOwnerDropdownList, placeholder: "Choose Pet Owner")
        self.setDropDownParameters(dropDown: self.selectPetDropdownList, placeholder: "Choose Pet")
        
        ApiService.sharedInstance.getAllPetOwners { (owners:[User]?) in
            if(owners != nil){
                self.petOwners = owners
                self.setDropDownData(dropDown: self.selectPetOwnerDropdownList)
            }
        }

        // Do any additional setup after loading the view.
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
    
    func setDropDownData(dropDown: SwiftyMenu){
        if(dropDown == self.selectPetOwnerDropdownList){
            for petowner in petOwners! {
                petOwnerOptionalData.append(DropdownRow(displayableValue: petowner.full_name, retrivableValue: petowner))
            }
            self.selectPetOwnerDropdownList.options = petOwnerOptionalData
        } else{
            petOptionalData.removeAll()
            for pet in pets!{
                petOptionalData.append(DropdownRow(displayableValue: pet.name, retrivableValue: pet))
            }
            self.selectPetDropdownList.options = petOptionalData
            self.selectPetDropdownList.selectedIndex = nil
            self.selectPetDropdownList.placeHolderColor = .blue
        }
    }

    @IBAction func seeProfileButtonPushed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            if(selectedPet != nil){
                let pc = storyboard?.instantiateViewController(identifier: "VetProfileViewsID") as! VetPetProfileViewController
                self.delegate = pc
                self.delegate?.petSelected(pet: self.selectedPet!, imageId: self.selectedPetImageId!)
                pc.view.frame = self.view.frame
                self.navigationController!.setNavigationBarHidden(true, animated: true)
                self.addChild(pc)
                self.view.addSubview(pc.view)
            } else {
                let alert = UIAlertController(title: "Selection error",
                                              message: "You must select the pet you want!",
                                              preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default,
                                           handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        if(swiftyMenu == self.selectPetOwnerDropdownList){
            self.selectedPet = nil
            let owner: User = selectedOption.retrivableValue as! User
            ApiService.sharedInstance.getAllPetsForOwner(id: owner.id) { (dog:[Dog]?, ids: [CLong]?) in
                self.pets = dog
                self.imageIds = ids
                self.setDropDownData(dropDown: self.selectPetDropdownList)
            }
        } else {
            self.selectedPet = selectedOption.retrivableValue as! Dog
            self.selectedPetImageId = self.imageIds![index]
        }
    }
}
