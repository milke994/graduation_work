//
//  ImageGalleryViewController.swift
//  PetService
//
//  Created by Dusan Milic on 30/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, imageToViewSelectedProtocol {
    func imageSelected(imageToPresent image: UIImage) {
        self.imageView.image = image
    }
    

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        (self.parent! as? VetPetProfileViewController)?.tabBarController?.tabBar.isHidden = false
        removeFromParent()
        self.view.removeFromSuperview()
    }

}
