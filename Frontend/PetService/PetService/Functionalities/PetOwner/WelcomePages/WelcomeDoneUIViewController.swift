//
//  WelcomeDoneUIViewController.swift
//  PetService
//
//  Created by Dusan Milic on 08/10/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class WelcomeDoneUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToHomepageFromSkip"){
            if(System.shared().getLogedInUser()!.firstLogin == 1){
                System.shared().getLogedInUser()!.firstLogin = 0
                ApiService.sharedInstance.changeFirstLogedIn()
            }
        }
    }

}
