//
//  VetBottomTabBarViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class VetBottomTabBarViewController: UITabBarController, UIViewControllerTransitioningDelegate, MenuItemSelectedProtocol {
    
    
    let transition: MenuSlideInTransition = MenuSlideInTransition()
    var activeMenuViewController: VetMenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = VetConstants.menuItems[0]
        self.tabBar.barTintColor = UIColor(white: 0.8, alpha: 0.5)
        self.tabBar.unselectedItemTintColor = UIColor(white:0, alpha: 0.5)
        self.tabBar.tintColor = .black
        // Do any additional setup after loading the view.
    }

    @IBAction func menuButtonClicked(_ sender: UIBarButtonItem) {
        if #available(iOS 13.0, *) {
            guard let menuViewController = storyboard?.instantiateViewController(identifier: "VetMenuViewController") as? VetMenuViewController else{
                return
            }
            if(!transition.isPresenting){
                menuViewController.modalPresentationStyle = .overCurrentContext
                menuViewController.transitioningDelegate = self
                menuViewController.delegate = self
                self.activeMenuViewController = menuViewController
                present(menuViewController, animated: true)
            } else {
                activeMenuViewController!.dismiss(animated: true)
                activeMenuViewController?.removeFromParent()
                self.activeMenuViewController = nil
            }
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    func itemSelected(row: Int) {
        if(row == 10){
            dismiss(animated: true)
        }else{
            self.navigationItem.title = VetConstants.menuItems[row]
            self.selectedIndex = row
        }
    }
}
