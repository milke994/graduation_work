//
//  RegisterViewController.swift
//  PetService
//
//  Created by Dusan Milic on 16/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate{
    
    var alertTitle : String = "";
    var alertMessage : String = "";
    let userTypes = ["Pet Owner", "Vet"];
    var selectedType: UserType = UserType.PET_OWNER;

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userTypePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userTypePickerView.dataSource = self;
        userTypePickerView.delegate = self;
        
        usernameTextField.delegate = self;
        usernameTextField.textContentType = .username;
        passwordTextField.delegate = self;
        passwordTextField.textContentType = .password;
        emailTextField.delegate = self;
        emailTextField.textContentType = .emailAddress;
        
        phoneNumberTextField.delegate = self;
        phoneNumberTextField.textContentType = .telephoneNumber;
    }
    
    
    @IBAction func submitClicked(){
        //TODO Check all fields and commit then to database
        if(usernameTextField.text == "" || passwordTextField.text == "" || emailTextField.text == "" || (!phoneNumberTextField.isHidden && phoneNumberTextField.text == "")){
            self.alertTitle = "Registration failed!";
            self.alertMessage = "You must enter all information";
            self.showAlert();
            return;
        }
        self.register(fullName: usernameTextField!.text!, email: emailTextField!.text!, password: passwordTextField!.text!, phoneNumber: phoneNumberTextField!.text!, userType: selectedType)
    }
    
    func register(fullName: String, email:String, password: String, phoneNumber: String, userType: UserType){
        ApiService.sharedInstance.register(fullName: fullName, email: email, password: password, phoneNumber: phoneNumber, userType: userType) {
            self.registrationDone()
        }
    }
    
    func registrationDone(){
        performSegue(withIdentifier: "backToLoginSegue", sender: self);
    }
    
    @IBAction func cancelClicked(){
        performSegue(withIdentifier: "backToLoginSegue", sender: self);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK:- pickerView functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(userTypes[row] == "Vet"){
            phoneNumberTextField.isHidden = false;
            selectedType = UserType.VET
        } else {
            phoneNumberTextField.isHidden = true;
            selectedType = UserType.PET_OWNER
        }
        print("user type is \(self.userTypes[row])");
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row];
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
}
