//
//  AllDogsTableView.swift
//  PetService
//
//  Created by Dusan Milic on 26/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class AllDogsTableView: UITableView, UITableViewDataSource {
    
    var dogsOwned: [Dog] = [];
    var activeDog: Dog? = nil;
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsOwned.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allDogsTableViewCell", for: indexPath);
        
        let imageView = cell.viewWithTag(40) as! UIImageView;
        imageView.layer.borderWidth = 1;
        imageView.layer.masksToBounds = false;
        imageView.layer.borderColor = UIColor.black.cgColor;
        imageView.layer.cornerRadius = imageView.frame.height/2;
        imageView.clipsToBounds = true;
        
        let dogNameLabel = cell.viewWithTag(41) as! UILabel;
        let dogBreedLabel = cell.viewWithTag(42) as! UILabel;
        
        let upArrow = cell.viewWithTag(43) as! UIButton;
        
        let index = indexPath.row;
        if(index == 0){
            upArrow.isHidden = false;
        }else{
            upArrow.isHidden = true;
        }
        
        if(dogsOwned[index] == System.shared().getActiveDog()!){
            cell.isSelected = true;
        } else {
            cell.isSelected = false;
        }
        if(dogsOwned[index].picture != nil){
            imageView.image = UIImage(data: dogsOwned[index].picture!.photo)
        }
        dogNameLabel.text = dogsOwned[index].name;
        dogBreedLabel.text = dogsOwned[index].breed;

        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true);
        let cell = tableView.dequeueReusableCell(withIdentifier: "allDogsTableViewCell", for: indexPath);
        cell.isSelected = true;
    }

}
