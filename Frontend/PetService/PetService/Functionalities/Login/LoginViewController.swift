//
//  ViewController.swift
//  PetService
//
//  Created by Dusan Milic on 16/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let storage = UserDefaults.standard;
    
    var alertTitle : String = "";
    var alertMessage : String = "";
    var logedIn: Int = 1;
    var user: User?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self;
        passwordTextField.delegate = self;
        passwordTextField.textContentType = .password;
        // Do any additional setup after loading the view.

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "homepageSegue") {
            print("performed");
        }
        if(segue.identifier == "welcomeSegue"){
            print("performed welcome segue");
        }
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
    
    @IBAction func loginClicked(){
        //TODO Check username and password in database
        
        if(usernameTextField!.text == "" || passwordTextField!.text == ""){
            self.alertMessage = "You must insert both username and password";
            self.alertTitle = "Login error";
            self.showAlert();
            return;
        } else {
            self.tryLogin(username: usernameTextField!.text!, password: passwordTextField!.text!)
        }
    }
    
    func tryLogin(username: String, password: String){

        ApiService.sharedInstance.login(username: username, password: password) { (logedIn: Int) in
            self.logedIn = logedIn
            self.loginDone()
        }
    }
    
    func loginDone(){
        if(logedIn == 1) {
            self.alertMessage = "We currently have problems with the server, we are very sorry and want you to know that we are doing everything in our power to make things right";
            self.alertTitle = "Server error";
            self.logedIn = 1
            showAlert();
        } else {
            if(logedIn == 2){
                self.alertMessage = "Wrong username and/or password";
                self.alertTitle = "Login error";
                self.logedIn = 1
                showAlert()
            } else{
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                self.user = System.shared().getLogedInUser()
                switch user!.type {
                case UserType.PET_OWNER:
                    if(user!.firstLogin == 0){
                        ApiService.sharedInstance.getAllPetsForOwner(id: self.user!.id) { (pets:[Dog]?, photoIds: [CLong]?) in
                            if(pets != nil){
                                var i: Int = 0
                                for pet in pets! {
                                    ApiService.sharedInstance.getProfilePicture(id: photoIds![i]) { (picture:Picture?) in
                                        pet.picture = picture
                                    }
                                    i+=1
                                }
                                System.shared().setPetsOwned(pets: pets!)
                                System.shared().setActiveDog(dog: pets![0])
                                
                            }
                            self.performSegue(withIdentifier: "homepageSegue", sender: self);
                        }
                    } else{
                        self.performSegue(withIdentifier: "welcomeSegue", sender: self)
                    }
                    break;
                case UserType.VET:
                    if(user!.firstLogin == 1){
                        performSegue(withIdentifier: "VetWelcomeSegue", sender: self)
                    } else {
                        performSegue(withIdentifier: "VetDirectHomepageSegue", sender: self)
                    }
                    break;
                }
            }
        }
    }
}

