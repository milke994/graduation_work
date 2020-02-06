//
//  AdditionalInfoViewController.swift
//  PetService
//
//  Created by Dusan Milic on 02/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol savedAdditionalInfoProtocol: class {
    func savedInfo()
}

class AdditionalInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, SwiftyMenuDelegate {
    
    let swiftMenuDisplays: [String] = ["-", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var delegate: savedAdditionalInfoProtocol?
    
    
    
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        self.getInfo()
        switch swiftyMenu {
        case self.indoorDropDownList:
            info!.indoor = Indoor_Outdoor(rawValue: selectedOption.displayableValue)
            break
        case self.foorTypeDropDownList:
            info!.food_type = FoodType(rawValue: selectedOption.displayableValue)
            break
        case self.mealSizeDropDownList:
            info!.meal_size = MealSize(rawValue: selectedOption.displayableValue)
            break
        case self.physicalActivityDropDownList:
            info!.physical_activity = PhysicalActivity(rawValue: selectedOption.displayableValue)
            break
        case self.travelingDropDownList:
            info!.traveling = Traveling(rawValue: selectedOption.displayableValue)
            break
        default:
            break
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return swiftMenuDisplays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return swiftMenuDisplays[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.getInfo()
        info!.meals_per_day = Int(swiftMenuDisplays[row])
    }
    
    func getInfo(){
        if(info == nil){
            info = PetAdditionalInfo(id: System.shared().getActiveDog()!.id, indoor: nil, foodType: nil, mealSize: nil, mealsPerDay: nil, physicalActivity: nil, traveling: nil)
        }
    }
    

    @IBOutlet weak var indoorDropDownList: SwiftyMenu!
    @IBOutlet weak var foorTypeDropDownList: SwiftyMenu!
    @IBOutlet weak var mealSizeDropDownList: SwiftyMenu!
    @IBOutlet weak var mealsPerDayPickerView: UIPickerView!
    @IBOutlet weak var physicalActivityDropDownList: SwiftyMenu!
    @IBOutlet weak var travelingDropDownList: SwiftyMenu!
    
    var indoorOptionsData: [SwiftyMenuDisplayable] = []
    var foodTypeOptionsData: [SwiftyMenuDisplayable] = []
    var mealSizeOptionsData: [SwiftyMenuDisplayable] = []
    var physicalActivityOptionsData: [SwiftyMenuDisplayable] = []
    var travelingOptionsData: [SwiftyMenuDisplayable] = []
    
    var info: PetAdditionalInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mealsPerDayPickerView.delegate = self
        self.mealsPerDayPickerView.dataSource = self
        
        self.setDropdownData(dropDown: indoorDropDownList)
        self.setDropdownData(dropDown: foorTypeDropDownList)
        self.setDropdownData(dropDown: mealSizeDropDownList)
        self.setDropdownData(dropDown: physicalActivityDropDownList)
        self.setDropdownData(dropDown: travelingDropDownList)
        
        self.setDropDownParameters(dropDown: indoorDropDownList)
        self.setDropDownParameters(dropDown: foorTypeDropDownList)
        self.setDropDownParameters(dropDown: mealSizeDropDownList)
        self.setDropDownParameters(dropDown: physicalActivityDropDownList)
        self.setDropDownParameters(dropDown: travelingDropDownList)
        
        
        self.info =  System.shared().getActiveDog()!.additionalInfo

        if(self.info != nil) {
            self.setActiveInfo()
        }
        // Do any additional setup after loading the view.
    }
    
    func setActiveInfo(){
        if(self.info!.indoor != nil){
            var i: Int = 0
            for item in Indoor_Outdoor.allCases {
                if(self.info!.indoor! == item){
                    self.indoorDropDownList.selectedIndex = i
                }
                i += 1
            }
        }
        
        if(self.info!.food_type != nil){
            var i: Int = 0
            for item in FoodType.allCases {
                if(self.info!.food_type! == item){
                    self.foorTypeDropDownList.selectedIndex = i
                }
                i += 1
            }
        }
        
        if(self.info!.meal_size != nil){
            var i: Int = 0
            for item in MealSize.allCases {
                if(self.info!.meal_size! == item){
                    self.mealSizeDropDownList.selectedIndex = i
                }
                i += 1
            }
        }
        
        if(self.info!.meals_per_day != nil){
            self.mealsPerDayPickerView.selectRow(self.info!.meals_per_day!, inComponent: 0, animated: true)
        }
        
        if(self.info!.physical_activity != nil){
            var i: Int = 0
            for item in PhysicalActivity.allCases {
                if(self.info!.physical_activity! == item){
                    self.physicalActivityDropDownList.selectedIndex = i
                }
                i += 1
            }
        }
        
        if(self.info!.traveling != nil){
            var i: Int = 0
            for item in Traveling.allCases {
                if(self.info!.traveling! == item){
                    self.travelingDropDownList.selectedIndex = i
                }
                i += 1
            }
        }
    }
    
    func setDropDownParameters(dropDown: SwiftyMenu) {
        dropDown.placeHolderText = "-"
        dropDown.arrow = UIImage(named: "Disclosure_Arrow_1");
        dropDown.delegate = self;
        dropDown.listHeight = 100
        dropDown.borderColor = .black
        dropDown.placeHolderColor = .blue
        dropDown.hideOptionsWhenSelect = true;
        
        dropDown.expandingAnimationStyle = .linear
        dropDown.expandingDuration = 0.5
        dropDown.collapsingAnimationStyle = .linear
        dropDown.collapsingDuration = 0.5
    }
    
    func setDropdownData(dropDown: SwiftyMenu){
        switch(dropDown){
            case self.indoorDropDownList:
                for item in Indoor_Outdoor.allCases {
                    self.indoorOptionsData.append(DropdownRow(displayableValue: "\(item)", retrivableValue: item))
                }
                self.indoorDropDownList.options = indoorOptionsData
                break
        case self.foorTypeDropDownList:
            for item in FoodType.allCases {
                self.foodTypeOptionsData.append(DropdownRow(displayableValue: "\(item)", retrivableValue: item))
            }
            self.foorTypeDropDownList.options = foodTypeOptionsData
            break
        case self.mealSizeDropDownList:
            for item in MealSize.allCases {
                self.mealSizeOptionsData.append(DropdownRow(displayableValue: "\(item)", retrivableValue: item))
            }
            self.mealSizeDropDownList.options = mealSizeOptionsData
            break
        case self.physicalActivityDropDownList:
            for item in PhysicalActivity.allCases {
                self.physicalActivityOptionsData.append(DropdownRow(displayableValue: "\(item)", retrivableValue: item))
            }
            self.physicalActivityDropDownList.options = physicalActivityOptionsData
            break
        case self.travelingDropDownList:
            for item in Traveling.allCases {
                self.travelingOptionsData.append(DropdownRow(displayableValue: "\(item)", retrivableValue: item))
            }
            self.travelingDropDownList.options = travelingOptionsData
            break
            default: break
        }
    }

    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        if(info != nil){
            System.shared().getActiveDog()!.additionalInfo = info
            ApiService.sharedInstance.savePetInfo()
        }
        self.delegate?.savedInfo()
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
}
