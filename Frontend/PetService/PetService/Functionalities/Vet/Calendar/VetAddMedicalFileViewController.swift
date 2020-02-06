//
//  VetAddMedicalFileViewController.swift
//  PetService
//
//  Created by Dusan Milic on 08/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class VetAddMedicalFileViewController: UIViewController, VetAppointmentSelectedProtocol, UITextFieldDelegate {
    

    @IBOutlet weak var diseasesTextField: UITextField!
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var treatmentsTextField: UITextField!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var dogLabel: UILabel!
    
    var delegate: vetInsertMeasureProtocol?
    
    var appointmentSelected: AppoinmentModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        if(self.appointmentSelected!.pet.medicalInfo != nil){
            self.diseasesTextField.text = self.appointmentSelected!.pet.medicalInfo!.diseases
            self.allergiesTextField.text = self.appointmentSelected!.pet.medicalInfo!.allergies
            self.treatmentsTextField.text = self.appointmentSelected!.pet.medicalInfo!.treatments
        }
        // Do any additional setup after loading the view.
        
        self.ownerLabel.text = self.appointmentSelected!.pet_owner.full_name
        self.dogLabel.text = self.appointmentSelected!.pet.name
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func addMeasureClicked(_ sender: Any) {
        let pc: PetProfilePopUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpId") as! PetProfilePopUpViewController
        self.addChild(pc)
        pc.view.frame = self.view.frame
        self.delegate = pc
        self.delegate?.vetAddMeasure(pet: self.appointmentSelected!.pet)
        self.view.addSubview(pc.view)
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        let medicalFile: MedicalFile = MedicalFile(id: self.appointmentSelected!.pet.id, diseases: self.diseasesTextField.text, allergies: self.allergiesTextField.text, treatments: self.treatmentsTextField.text)
        
        ApiService.sharedInstance.createMedicalInfo(medicalFile: medicalFile)
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func appointmentSelected(appointment: AppoinmentModel) {
        self.appointmentSelected = appointment
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
