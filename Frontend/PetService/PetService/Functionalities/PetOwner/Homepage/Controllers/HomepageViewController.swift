//
//  HomepageViewController.swift
//  PetService
//
//  Created by Dusan Milic on 21/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    lazy var tipsViewController: Tips_TricksViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "Tips_TricksViewController") as! Tips_TricksViewController;
        
        self.addViewControllerAsChild(childViewController: viewController);
        
        return viewController;
    }();
    
    lazy var petProfileViewController: PetProfileViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "PetProfileViewController") as! PetProfileViewController;
        
        self.addViewControllerAsChild(childViewController: viewController);
        
        return viewController;
    }()
    
    lazy var calendarViewController: CalendarViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController;
        
        self.addViewControllerAsChild(childViewController: viewController);
        
        return viewController;
    }();
    
    lazy var notificationsViewController: NotificationsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController;
        
        self.addViewControllerAsChild(childViewController: viewController);
        
        return viewController;
    }();
    
    lazy var chatViewController: ChatViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController;
        
        self.addViewControllerAsChild(childViewController: viewController);
        
        return viewController;
    }()
    
    var buttonBar: ButtonBarViewController?;
    let storage = UserDefaults.standard
    var v: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBar = (children[0] as! ButtonBarViewController);
        v = view.viewWithTag(123)!
        self.home(sender: self);
//        let user: User = UserDefaults.standard.value(forKey: "userLogedIn") as! User;
//        print(user.email);
//        print(user.full_name);
    }
    
    
    @IBAction func showPopUp(sender: AnyObject){
        let popUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpMenuViewId") as! MenuViewController;
        self.addChild(popUp);
        popUp.view.frame = self.view.frame;
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(popUp.view);
        }, completion: nil);
        popUp.didMove(toParent: self);
    }
    
    
    //MARK:- managing views
    @IBAction func calendar(sender: AnyObject){
        self.petProfileViewController.view.isHidden = true;
        self.calendarViewController.view.isHidden = false;
        self.tipsViewController.view.isHidden = true;
        self.notificationsViewController.view.isHidden = true;
        self.chatViewController.view.isHidden = true;
        self.navigationBar.topItem?.title = "Calendar&Scheduling"
    }
    
    @IBAction func petProfile(sender: AnyObject){
        self.petProfileViewController.view.isHidden = false;
        self.calendarViewController.view.isHidden = true;
        self.tipsViewController.view.isHidden = true;
        self.notificationsViewController.view.isHidden = true;
        self.chatViewController.view.isHidden = true;
        self.navigationBar.topItem?.title = "Pet profile"
    }
    
    @IBAction func home(sender: AnyObject){
        self.petProfileViewController.view.isHidden = true;
        self.calendarViewController.view.isHidden = true;
        self.tipsViewController.view.isHidden = false;
        self.notificationsViewController.view.isHidden = true;
        self.chatViewController.view.isHidden = true;
        self.navigationBar.topItem?.title = "Tips&Tricks"
    }
    
    @IBAction func notifications(sender: AnyObject){
        self.petProfileViewController.view.isHidden = true;
        self.calendarViewController.view.isHidden = true;
        self.tipsViewController.view.isHidden = true;
        self.notificationsViewController.view.isHidden = false;
        self.chatViewController.view.isHidden = true;
        self.navigationBar.topItem?.title = "Notifications"
    }
    
    @IBAction func chat(sender: AnyObject){
        self.petProfileViewController.view.isHidden = true;
        self.calendarViewController.view.isHidden = true;
        self.tipsViewController.view.isHidden = true;
        self.notificationsViewController.view.isHidden = true;
        self.chatViewController.view.isHidden = false;
        self.navigationBar.topItem?.title = "Chat"
    }
    
    private func addViewControllerAsChild(childViewController: UIViewController){
        self.addChild(childViewController);
        self.v.addSubview(childViewController.view);
        childViewController.view.frame = v.bounds;
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        childViewController.didMove(toParent: self);
    }
    
    
    public func callViewController(){
        
        if #available(iOS 13.0, *) {
            let pcc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "phoneCallSBId") as! PhoneCallsViewController
            pcc.view.frame = self.view.frame
            addChild(pcc)
            self.view.addSubview(pcc.view)
        }
    }
    
    @IBAction func logout(){
        performSegue(withIdentifier: "logout", sender: self);
    }
}
