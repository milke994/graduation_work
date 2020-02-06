//
//  MedicalCollectionViewCell.swift
//  PetService
//
//  Created by Dusan Milic on 21/11/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol reloadDataProtocol: class {
    func addMeasureViewControllerDidCancel(_ controller: PetProfilePopUpViewController)
    
    func addMeasureViewController(_ controller: PetProfilePopUpViewController,
                                  didFinishAdding measure: Measurement)
}

class MedicalCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, reloadDataProtocol {
    
    func addMeasureViewControllerDidCancel(_ controller: PetProfilePopUpViewController) {
    }
    
    func addMeasureViewController(_ controller: PetProfilePopUpViewController, didFinishAdding measure: Measurement) {
        if(measure.measure > self.max){
            self.max = measure.measure
        }
        self.measurements.append(measure)
        self.barChartCollectionView.reloadData()
    }
    
    
    var measurements: [Measurement] = []
    
    @IBOutlet weak var barChartCollectionView: UICollectionView!
    let cellId: String = "cellId"
    var max :Float = 0
    var height = 0
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func didMoveToWindow() {
        barChartCollectionView.delegate = self
        barChartCollectionView.dataSource = self
        barChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.setupDateFormatter()
        self.getMeasures()
    }
    
    func getMeasures(){
        ApiService.sharedInstance.getMeasurementsForPet(petId: System.shared().getActiveDog()!.id) { (measures: [Measurement]?) in
            if(measures != nil){
                self.measurements = measures!
                self.max = 0
                for measure in self.measurements{
                    if measure.measure > self.max{
                        self.max = measure.measure
                    }
                }
            } else{
                self.measurements = []
            }
            self.barChartCollectionView.reloadData()
        }
    }
    
    func setupDateFormatter(){
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return measurements.count
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
        dateLabel.text = measurements[indexPath.item].time
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 8, height: collectionView.frame.height)
    }
    
    
}
