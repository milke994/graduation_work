//
//  WelcomeDoneViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class WelcomeDoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "VetHomepageSegue"){
            if(System.shared().getLogedInUser()!.firstLogin == 1){
                ApiService.sharedInstance.changeFirstLogedIn()
            }
        }
    }

}
