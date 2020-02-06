//
//  MenuViewController.swift
//  PetService
//
//  Created by Dusan Milic on 21/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var dogPicture: UIImageView!
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var dogBreed: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tableOne: TableOneTableView!
    @IBOutlet weak var tableTwo: UITableView!
    @IBOutlet weak var allDogsTable: AllDogsTableView!
    
    lazy var table1: TableOneTableView = TableOneTableView();
    lazy var table2: TableTwoTableView = TableTwoTableView();
    lazy var allDogsTableView: AllDogsTableView = AllDogsTableView();
    
    var dogsOwned: [Dog] = [];
    var activeDog: Dog? = nil;
    
    var parentController : HomepageViewController? = nil;
    
    let storage = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        
        self.dogsOwned = System.shared().getPetsOwned()!;
        self.activeDog = System.shared().getActiveDog()!;
        
        self.setTablesDelegatesAndDataSources();
        
        self.allDogsTableView.activeDog = activeDog;
        self.allDogsTableView.dogsOwned = dogsOwned;
        
        let indexPath = IndexPath(row: dogsOwned.firstIndex(of: activeDog!)!, section: 0);
        allDogsTable.selectRow(at: indexPath, animated: false, scrollPosition: .top);
      
        self.setActiveDog();
        parentController = (self.parent as! HomepageViewController);
    }
    
    func setTablesDelegatesAndDataSources(){
        tableOne.dataSource = table1;
        tableOne.delegate = self;
        
        tableTwo.dataSource = table2;
        tableTwo.delegate = self;
        
        allDogsTable.dataSource = allDogsTableView;
        allDogsTable.delegate = self;
    }
    
    func setActiveDog(){
        if(activeDog!.picture != nil){
            profilePicture.image = UIImage(data: activeDog!.picture!.photo)
        }
        profilePicture.layer.borderWidth = 1;
        profilePicture.layer.masksToBounds = false;
        profilePicture.layer.borderColor = UIColor.black.cgColor;
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2;
        profilePicture.clipsToBounds = true;
        
        dogName.text = activeDog!.name;
        dogBreed.text = activeDog!.breed;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        switch tableView {
        case tableOne:
            switch indexPath.row {
            case 0:
                parentController?.buttonBar?.petButtonClicked();
                break;
            case 1:
                parentController?.buttonBar?.calendarButtonClicked();
                break;
            case 2:
                parentController?.buttonBar?.notificationsButtonClicked();
                break;
            case 3:
                parentController?.buttonBar?.chatButtonClicked();
                break;
            case 4:
                parentController!.callViewController()
                break
            default:
                break;
            }
            break;
        case tableTwo:
            print("table two clicked at \(indexPath.row)");
            switch indexPath.row {
            case 3:
                parentController?.logout();
                break;
            default:
                break;
            }
            break;
        case allDogsTable:
            System.shared().setActiveDog(dog: dogsOwned[indexPath.row]);
            self.activeDog = dogsOwned[indexPath.row];
            self.setActiveDog();
            NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshData"), object: nil)
//            storage.set(self.activeDog, forKey: "ActiveDog");
            break;
        default:
            print("error!");
        }
        if(allDogsTable.isHidden){
            self.closePopUp(sender: self);
        } else{
            self.closeAllDogsTable(sender: self);
        }
    }
    @IBAction func closePopUp(sender: AnyObject){
        UIView.transition(with: parentController!.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.view.removeFromSuperview();
        }, completion: nil)
    }
    
    @IBAction func openAllDogsTable(sender: AnyObject){
        UIView.transition(with: parentController!.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.allDogsTable.isHidden = false;
        }, completion: nil)
    }
    
    @IBAction func closeAllDogsTable(sender: AnyObject){
        UIView.transition(with: parentController!.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.allDogsTable.isHidden = true;
        }, completion: nil)
    }
    
    @IBAction func addNewPetButtonClicked(Sender: AnyObject){
        performSegue(withIdentifier: "addNewPet", sender: self);
    }

}
