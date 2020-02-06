//
//  ButtonBarViewController.swift
//  PetService
//
//  Created by Dusan Milic on 21/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class ButtonBarViewController: UIViewController {

    @IBOutlet weak var petButton: UIBarButtonItem!;
    @IBOutlet weak var calendarButton: UIBarButtonItem!;
    @IBOutlet weak var homeButton: UIBarButtonItem!;
    @IBOutlet weak var notificationsButton: UIBarButtonItem!;
    @IBOutlet weak var chatButton: UIBarButtonItem!;
    
    var buttons : [UIBarButtonItem] = [];
    var lastClicked = 2;
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        buttons.append(petButton);
        buttons.append(calendarButton);
        buttons.append(homeButton);
        buttons.append(notificationsButton);
        buttons.append(chatButton);
        
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button functions
    @IBAction func petButtonClicked(){
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(0.3);
        lastClicked = 0;
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(1);
        let p = parent as! HomepageViewController;
        p.petProfile(sender: self);
    }
    
    @IBAction func calendarButtonClicked(){
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(0.3);
        lastClicked = 1;
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(1);
        let p = parent as! HomepageViewController;
        p.calendar(sender: self);
    }
    
    @IBAction func homeButtonClicked(){
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(0.3);
        lastClicked = 2;
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(1);
        let p = parent as! HomepageViewController;
        p.home(sender: self);
    }
    
    @IBAction func notificationsButtonClicked(){
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(0.3);
        lastClicked = 3;
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(1);
        let p = parent as! HomepageViewController;
        p.notifications(sender: self);
    }
    
    @IBAction func chatButtonClicked(){
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(0.3);
        lastClicked = 4;
        buttons[lastClicked].tintColor = UIColor.black.withAlphaComponent(1);
        let p = parent as! HomepageViewController;
        p.chat(sender: self);
    }

}
