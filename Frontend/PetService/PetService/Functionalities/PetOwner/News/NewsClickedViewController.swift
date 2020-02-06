//
//  NewsClickedViewController.swift
//  PetService
//
//  Created by Dusan Milic on 25/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol newsSelectedProtocol: class {
    func userSelectedNews(_ controller: Tips_TricksViewController, newsSelected news: News)
}

class NewsClickedViewController: UIViewController, newsSelectedProtocol {
    func userSelectedNews(_ controller: Tips_TricksViewController, newsSelected news: News) {
        self.newsSelected = news
    }
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var newsSelected: News?
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = newsSelected!.title
        imageView.image = newsSelected!.picture
        textLabel.text = newsSelected!.text
    }

    @IBAction func closeButtonClicked(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
