//
//  WelcomePageViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(viewControllerIdentifier: "VetWelcomePageOne"),
                self.newViewController(viewControllerIdentifier: "VetWelcomePageTwo"),
                self.newViewController(viewControllerIdentifier: "VetWelcomePageThree")];
    }();
    
    var pageControll = UIPageControl();
    var skipButton = UIButton();
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self;
        if let firstViewController = orderedViewControllers.first{
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true, completion: nil);
        }
        self.delegate = self;
        self.configurePageControll();
        // Do any additional setup after loading the view.
    }
    
    func configurePageControll(){
        pageControll = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50));
        pageControll.numberOfPages = orderedViewControllers.count;
        pageControll.currentPage = 0;
        pageControll.tintColor = UIColor.black;
        pageControll.pageIndicatorTintColor = UIColor.gray;
        pageControll.currentPageIndicatorTintColor = UIColor.black;
        self.view.addSubview(pageControll);
        skipButton = UIButton.init(frame: CGRect(x: UIScreen.main.bounds.maxX - 250, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50));
        skipButton.setTitle("SKIP", for: .normal);
        skipButton.setTitleColor(UIColor.blue, for: .normal);
        skipButton.addTarget(self, action: #selector(skipPageOnePressed(_ :)), for: .touchUpInside)
        self.view.addSubview(skipButton);
    }
    
    @objc func skipPageOnePressed(_ : UIButton){
        self.pageControll.currentPage+=1;
        if(self.pageControll.currentPage < 3){
            setViewControllers([orderedViewControllers[pageControll.currentPage]],
                               direction: .forward,
                               animated: true, completion: nil);
            if(self.pageControll.currentPage == 2){
                skipButton.isHidden = true;
            }
        }
    }
    
    
    
    func newViewController(viewControllerIdentifier: String)->UIViewController{
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewControllerIdentifier);
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil;
        }
        
        let previousIndex = viewControllerIndex - 1;
        guard (previousIndex >= 0) else {
            return nil;
        }
        
        guard (orderedViewControllers.count > previousIndex) else {
            return nil;
        }
        if (skipButton.isHidden){
            skipButton.isHidden = !skipButton.isHidden;
        }
        return orderedViewControllers[previousIndex];
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                    return nil;
                }
                
                let nextIndex = viewControllerIndex + 1;
                guard (orderedViewControllers.count != nextIndex) else {
                    return nil;
                }
                
                guard (!skipButton.isHidden) else {
                    return nil;
                }
                
                if(pageControll.currentPage == 1){
                    skipButton.isHidden = true;
                }
                
                guard (orderedViewControllers.count > nextIndex) else {
                    return nil;
                }
                
                return orderedViewControllers[nextIndex];
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0];
        self.pageControll.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!;
    }
    

}
