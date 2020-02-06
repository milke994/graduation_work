//
//  Tips&TricksViewController.swift
//  PetService
//
//  Created by Dusan Milic on 26/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class Tips_TricksViewController: UITableViewController {
    
    var news :[News] = [];
    var delegate: newsSelectedProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.makeNews()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableCell",for: indexPath);
        let dateLabel = cell.viewWithTag(71) as! UILabel;
        let imageView = cell.viewWithTag(72) as! UIImageView;
        let textLabel = cell.viewWithTag(73) as! UILabel;
        
        dateLabel.text = news[indexPath.row].title;
        imageView.image = news[indexPath.row].picture;
        textLabel.text = news[indexPath.row].text;
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        if #available(iOS 13.0, *) {
            let newsSelectedController: NewsClickedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewsClickedControllerId") as! NewsClickedViewController
            self.delegate = newsSelectedController
            delegate?.userSelectedNews(self, newsSelected: news[indexPath.row])
            addChild(newsSelectedController)
            newsSelectedController.view.frame = self.view.frame
            self.view.addSubview(newsSelectedController.view)
        }
        //TODO open a new view to display the news user clicked on
    }
    
    func makeNews(){
        var n = News(title: "10 best dog toys", picture: UIImage(named: "dogToys")!, text: "For dog owners, there’s endless pleasure to be had in watching your pooch having fun. \n\nPlaytime is a serious business for our canine friends and, although the temptation is to focus on it in the cold winter months when your dog is likely to be inside more, Steve Mann, who runs the Institute of Modern Dog Trainers and author of Easy Peasy Puppy Squeezy, explains: Play should happen every day of the year – it’s not seasonal. \n\nFor dogs, play can develop the ability to bond, to improvise, to be social and to practise impulse control. \n\nIt’s important throughout a dog’s life but especially so in the early stages of puppyhood as it increases their ability to form relationships.  Mann recommends that dog owners have toys in a selection of sizes, shapes and textures to offer variety.");
        news.append(n);
        n = News(title: "10 best dog collars", picture: UIImage(named: "dogNews2")!, text: "Collars aren’t just a fashion statement for stylish pooches, they are a legal requirement. All dogs must wear a collar with an ID badge detailing their owners’ names and contact details when in a public place. \n\nYour dog’s collar should be well-fitting and comfortable for your dog to wear, says PDSA vet Olivia Anderson-Nathan. \n\nWhen fitting a collar to your dog, make sure it’s not too tight – a good rule of thumb is that you can fit two fingers under the collar all the way around your dog’s neck – or too loose, as then they could slip or back out of it.  \n\nShe also advises avoiding collars with prongs, electric-shock devices and choke chains, as they can all cause discomfort and even pain. \n\nIf you have a puppy you will need to check the collar every few weeks and replace it when it’s getting tight and be ready to replace or tighten or loosen a collar on an older dog if he or she loses or gains weight.");
        news.append(n);
    }

}
