//
//  barView.swift
//  PetService
//
//  Created by Dusan Milic on 25/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class barView: UIView {
    
    var barHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.barHeightConstraint = self.heightAnchor.constraint(equalToConstant: 200)
        self.barHeightConstraint?.isActive = true
    }
    
}
