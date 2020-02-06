//
//  PhoneCallsViewController.swift
//  PetService
//
//  Created by Dusan Milic on 01/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class PhoneCallsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var phoneCallsTableView: UITableView!
    
    var vets: [User] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phoneCellId", for: indexPath)
        
        let nameLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let phoneLabel:UILabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = self.vets[indexPath.row].full_name
        phoneLabel.text = self.vets[indexPath.row].phoneNumber!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.removeFromParent()
        self.view.removeFromSuperview()
        
        let url: URL = URL(string: "tel://\(self.vets[indexPath.row].phoneNumber!)")!
        UIApplication.shared.open(url)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.sharedInstance.getAllVets { (users:[User]?) in
            if(users != nil){
                self.vets = users!
                self.phoneCallsTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

}
