//
//  AddNewPetViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/10/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class AddNewPetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, SwiftyMenuDelegate{
    
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        print("Selected option: \(selectedOption), at index: \(index)")
        if(swiftyMenu == speciesDropDown){
            speciesSelected = Species(rawValue: index)
            self.setBreedsDropdownData()
        } else {
            if(swiftyMenu == breedsDropDown){
                switch speciesSelected! {
                case .Dog:
                    breedSelected = DogBreeds(rawValue: index)
                    break
                case .Cat:
                    breedSelected = CatBreeds(rawValue: index)
                    break
                case .Fish:
                    breedSelected = FishBreeds(rawValue: index)
                    break
                case .Hamster:
                    breedSelected = HamsterBreeds(rawValue: index)
                    break
                case .Snake:
                    breedSelected = SnakeBreeds(rawValue: index)
                    break
                }
            } else{
                genreSelected = Genre(rawValue: index);
            }
        }
    }

    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var yearOfBirth: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var speciesSelected: Species?
    var breedSelected: Any?
    var genreSelected: Genre?

    
    @IBOutlet weak var speciesDropDown: SwiftyMenu!
    @IBOutlet weak var breedsDropDown: SwiftyMenu!
    @IBOutlet weak var genreDropDown: SwiftyMenu!
    
    
    var optionsData :[SwiftyMenuDisplayable] = [];
    var breedsOptionsData: [SwiftyMenuDisplayable] = [];
    var genresOptionsData: [SwiftyMenuDisplayable] = [];
    
    var alertTitle : String = "";
    var alertMessage : String = "";
    
    let imagePicker = UIImagePickerController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDropDownParameters(dropDown: speciesDropDown, placeholder: "Species")
        self.setDropDownParameters(dropDown: breedsDropDown, placeholder: "Breed")
        self.setDropDownParameters(dropDown: genreDropDown, placeholder: "Genre")
        self.setSpeciesDropDownData(dropDown: speciesDropDown);
        self.setGenreDropdownData();
        petName.delegate = self;
        yearOfBirth.delegate = self;
        weight.delegate = self;

        // Do any additional setup after loading the view.
    }
    
    func setSpeciesDropDownData(dropDown: SwiftyMenu){
        for specie in Species.allCases {
            optionsData.append(DropdownRow(displayableValue: "\(specie)", retrivableValue: specie))
        }
        dropDown.options = optionsData;
    }
    
    func setGenreDropdownData(){
        for genre in Genre.allCases{
            genresOptionsData.append(DropdownRow(displayableValue: "\(genre)", retrivableValue: genre))
        }
        genreDropDown.options = genresOptionsData;
    }
    
    func setBreedsDropdownData(){
        breedsOptionsData.removeAll()
        breedSelected = nil
        switch speciesSelected! {
        case .Dog:
            for breed in DogBreeds.allCases{
                breedsOptionsData.append(DropdownRow(displayableValue: "\(breed)", retrivableValue: breed))
            }
            break
        case .Cat:
            for breed in CatBreeds.allCases{
                breedsOptionsData.append(DropdownRow(displayableValue: "\(breed)", retrivableValue: breed))
            }
            break
        case .Fish:
            for breed in FishBreeds.allCases{
                breedsOptionsData.append(DropdownRow(displayableValue: "\(breed)", retrivableValue: breed))
            }
            break
        case .Hamster:
            for breed in HamsterBreeds.allCases{
                breedsOptionsData.append(DropdownRow(displayableValue: "\(breed)", retrivableValue: breed))
            }
            break
        case .Snake:
            for breed in SnakeBreeds.allCases{
                breedsOptionsData.append(DropdownRow(displayableValue: "\(breed)", retrivableValue: breed))
            }
            break
        }
        breedsDropDown.options = breedsOptionsData
        breedsDropDown.selectedIndex = nil
        breedsDropDown.placeHolderColor = .blue;
    }
    
    func setDropDownParameters(dropDown: SwiftyMenu, placeholder: String) {
        dropDown.placeHolderText = placeholder
        dropDown.arrow = UIImage(named: "Disclosure_Arrow_1");
        dropDown.delegate = self;
        if(dropDown == genreDropDown){
            dropDown.listHeight = 100
        } else{
            dropDown.listHeight = 150;
        }
        dropDown.borderColor = .black
        dropDown.placeHolderColor = .blue
        dropDown.hideOptionsWhenSelect = true;
        
        dropDown.expandingAnimationStyle = .linear
        dropDown.expandingDuration = 0.5
        dropDown.collapsingAnimationStyle = .linear
        dropDown.collapsingDuration = 0.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    @IBAction func showAlert() {
        let alert = UIAlertController(title: self.alertTitle,
                                      message: self.alertMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        if(petName.text! == "" || yearOfBirth.text! == "" || speciesSelected == nil || genreSelected == nil
            || breedSelected == nil || weight.text! == "" || self.image.image == nil){
            self.alertMessage = "You must insert all info";
            self.alertTitle = "Adding pet error";
            self.showAlert();
            return;
        } else {
            let name = petName.text!
            let a = Int(yearOfBirth.text!)!
            let b = Float(weight.text!)!
            let newPet = NewPet(owner_id: System.shared().getLogedInUser()!.id, name: petName.text!, species: "\(speciesSelected!)", breed: "\(breedSelected!)", age: Int(yearOfBirth.text!)!, weight: Float(weight.text!)!)
            ApiService.sharedInstance.createPet(newPet: newPet) { (dog:Dog) in
                let picture = NewPicture(petId: dog.id, picture: self.image.image!.toString()!)
                ApiService.sharedInstance.setProfileImage(picture: picture) { (id: CLong) in
                    dog.picture = Picture(id: id, petId: dog.id, image: self.image.image!.toString()!)
                    if(System.shared().getLogedInUser()!.firstLogin == 0){
                       var dogs: [Dog]? = System.shared().getPetsOwned()
                       dogs!.append(dog)
                       System.shared().setPetsOwned(pets: dogs!)
                       self.performSegue(withIdentifier: "addingPetDone", sender: self)
                    } else{
                       System.shared().setActiveDog(dog: dog)
                       var dogs = [Dog]()
                       dogs.append(dog)
                       System.shared().setPetsOwned(pets: dogs);
                       self.performSegue(withIdentifier: "addingFirstPetDone", sender: self)
                    }
                }
            }
        }
    }
    @IBAction func addImageButtonClicked(_ sender: Any) {
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum;
        self.present(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        if(System.shared().getLogedInUser()!.firstLogin == 1){
            performSegue(withIdentifier: "addingPetCanceled", sender: self)
        } else {
            performSegue(withIdentifier: "addingPetDone", sender: self)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.image.image = image;
        }
        dismiss(animated: true, completion: nil);
    }
    
}
