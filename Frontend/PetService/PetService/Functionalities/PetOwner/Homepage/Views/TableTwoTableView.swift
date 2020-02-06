//
//  TableTwoTableView.swift
//  PetService
//
//  Created by Dusan Milic on 22/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class TableTwoTableView: UITableView, UITableViewDataSource {
    
    var labels = ["App settings", "My account settings", "Feedback & support", "Logout"];
    var icons = [UIImage(named: "icons8-settings-30"), UIImage(named: "icons8-account-30"), UIImage(named: "icons8-handshake-30"), UIImage(named: "icons8-power-off-button-30")];
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableTwoCell", for: indexPath);
        
        let imageView = cell.viewWithTag(20) as! UIImageView;
        let label = cell.viewWithTag(21) as! UILabel;
        
        imageView.image = icons[indexPath.row];
        label.text = labels[indexPath.row];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    


}
