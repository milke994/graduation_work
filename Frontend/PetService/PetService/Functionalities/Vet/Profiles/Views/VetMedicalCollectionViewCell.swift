//
//  VetMedicalCollectionViewCell.swift
//  PetService
//
//  Created by Dusan Milic on 04/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class VetMedicalCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, petSelectedProtocol {
    
    func petSelected(pet: Dog, imageId: CLong) {
        ApiService.sharedInstance.getMeasurementsForPet(petId: pet.id) { (measures:[Measurement]?) in
            if(measures != nil){
                self.measurements = measures!
                self.barChartCollectionView.reloadData()
            }
        }
    }
    
    
    
    @IBOutlet weak var barChartCollectionView: UICollectionView!
    var measurements: [Measurement] = []
    let cellId: String = "cellId"
    var max :Float = 0
    var height = 0
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func didMoveToWindow() {
        barChartCollectionView.delegate = self
        barChartCollectionView.dataSource = self
        barChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.setupDateFormatter()
        //TODO get measurements from database
    }
    
    func setupDateFormatter(){
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        measurements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        for measure in self.measurements{
            if(measure.measure > self.max){
                self.max = measure.measure
            }
        }
        
        
        let ratio = measurements[indexPath.item].measure / self.max
        let height = (collectionView.frame.height - 30) * CGFloat(ratio)
        
        let measureLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let dateLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let barLine: barView = cell.viewWithTag(3) as! barView
        
        barLine.barHeightConstraint?.constant = height
        measureLabel.text = String(measurements[indexPath.item].measure)
        dateLabel.text = measurements[0].time
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 8, height: collectionView.frame.height)
    }
    
}
