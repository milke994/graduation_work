//
//  TableOneTableView.swift
//  PetService
//
//  Created by Dusan Milic on 22/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class TableOneTableView: UITableView, UITableViewDataSource{
    
    
    var labels = ["Pet profile", "Calendar & Scheduling", "My alerts", "Chat with veterinarian", "Emergency call"];
    var photos = [UIImage(named: "icons8-dog-paw-30"), UIImage(named: "icons8-calendar-12-30 (1)"), UIImage(named: "icons8-bell-30 (1)"), UIImage(named: "icons8-chat-30 (1)"), UIImage(named: "icons8-call-30 (1)")];
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTable1Cell", for: indexPath);
        
        let imageView = cell.viewWithTag(110) as! UIImageView;
        let label = cell.viewWithTag(10) as! UILabel;
        imageView.image = photos[indexPath.row];
        label.text = labels[indexPath.row];
        if(indexPath.row == 4){
            let label2 = cell.viewWithTag(11) as! UILabel;
            label2.isHidden = false;
            label2.text = "Paid service"
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
}
