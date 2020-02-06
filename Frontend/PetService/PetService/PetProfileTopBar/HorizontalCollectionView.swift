//
//  HorizontalCollectionView.swift
//  PetService
//
//  Created by Dusan Milic on 18/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import Foundation
import UIKit

public class HorizontalCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let cellId: String = "cellId"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
}
