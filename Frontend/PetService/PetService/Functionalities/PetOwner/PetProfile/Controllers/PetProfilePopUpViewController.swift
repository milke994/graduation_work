//
//  PetProfilePopUpViewController.swift
//  PetService
//
//  Created by Dusan Milic on 22/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol addMeasureProtocol: class {
    func addMeasureViewControllerDidCancel(_ controller: PetProfilePopUpViewController)
    
    func addMeasureViewController(_ controller: PetProfilePopUpViewController,
                                  didFinishAdding measure: Measurement)
}

protocol vetInsertMeasureProtocol: class{
    func vetAddMeasure(pet: Dog)
}

class PetProfilePopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, vetInsertMeasureProtocol {
    
    let numbers:[String] = ["_","0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var selectedNumbers: [String] = ["_","_","_"]
    
    let dateFormatter: DateFormatter = DateFormatter()
    var pet: Dog?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 2){
            return 1
        } else {
            return numbers.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 2){
            return "."
        }else{
            return numbers[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 3){
            selectedNumbers[component - 1] = numbers[row]
        } else {
            selectedNumbers[component] = numbers[row]
        }
    }
    
    
    
    weak var delegate: addMeasureProtocol?
    @IBOutlet weak var measurePickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        self.setupDateFormatter()
        // Do any additional setup after loading the view.
    }
    
    func setupDateFormatter(){
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Error",
                                      message: "You must enter the measure",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func addButtonClicked(_ sender: Any) {
        if(self.selectedNumbers == ["_","_","_"]){
            self.showAlert()
        } else {
            var number: String = ""
            var i = 0
            for num in selectedNumbers{
                if(num != "_"){
                    if(i == 2){
                        if(number == ""){
                            number = number + "0."
                        } else {
                            number = number + "."
                        }
                    }
                    number = number + num
                }
                i+=1
            }
            let kg: Float = Float(number)!
            if(self.pet == nil){
            let measure: NewMeasure = NewMeasure(pet_id: System.shared().getActiveDog()!.id, measure: kg, time: "\(Date())")
            ApiService.sharedInstance.createMeasurement(measure: measure)
            } else {
                let measure: NewMeasure = NewMeasure(pet_id: self.pet!.id, measure: kg, time: "\(Date())")
                ApiService.sharedInstance.createMeasurement(measure: measure)
            }
            let measure2: Measurement = Measurement(measure: kg, date: dateFormatter.string(from: Date()))
            
            delegate?.addMeasureViewController(self, didFinishAdding: measure2)
            self.view.removeFromSuperview()
        }
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        delegate?.addMeasureViewControllerDidCancel(self)
        self.view.removeFromSuperview()
    }
    
    
    func vetAddMeasure(pet: Dog) {
        self.pet = pet
    }
}
