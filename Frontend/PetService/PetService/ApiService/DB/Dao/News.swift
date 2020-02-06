//
//  News.swift
//  PetService
//
//  Created by Dusan Milic on 28/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation
import UIKit

class News: NSObject {
    let title: String;
    let picture: UIImage;
    let text: String;
    
    init(title: String, picture: UIImage, text: String) {
        self.title = title
        self.picture = picture;
        self.text = text;
    }
}
