//
//  ImageExtensions.swift
//  PetService
//
//  Created by Dusan Milic on 05/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
