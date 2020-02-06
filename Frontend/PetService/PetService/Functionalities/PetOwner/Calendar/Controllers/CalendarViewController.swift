//
//  CalendarViewController.swift
//  PetService
//
//  Created by Dusan Milic on 26/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol AppointmentSelectedProtocol {
    func appointmentSelected(appointment: Appointment, vetsName: String)
}

protocol AppointmentInsertedProtocol {
    func appointmentInserted()
}

class CalendarViewController: UIViewController, SwiftyMenuDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AppointmentInsertedProtocol {
    
    var delegate: AppointmentSelectedProtocol?
    
    let cellId: String = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.workingTimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let timeLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let dogsNameLabel: UILabel = cell.viewWithTag(2) as! UILabel
        
        timeLabel.text = Constants.workingTimes[indexPath.item]
        
        dogsNameLabel.isHidden = true
        cell.backgroundColor = .lightGray
        if(appointments.count > 0){
            for appointment in appointments {
                if(checkIfEqual(date1: Constants.workingTimes[indexPath.item], date2: appointment.time)){
                    self.appointmentFlag[indexPath.item] = true
                    cell.backgroundColor = .red
                    if(appointment.pet.ownerId == System.shared().getLogedInUser()!.id){
                        dogsNameLabel.text! = appointment.pet.name
                        dogsNameLabel.isHidden = false
                    }
                }
            }
        }
        return cell
    }
    
    func resetFlags(){
        self.appointmentFlag.removeAll()
        for _ in Constants.workingTimes{
            self.appointmentFlag.append(false)
        }
    }
    
    func checkIfEqual(date1: String, date2: String)->Bool{
        let components: [String] = date1.components(separatedBy: ":")
        let c: [String] = date2.components(separatedBy: " ")
        let components2: [String] = c[1].components(separatedBy: ":")
        if(components[0] == components2[0] && components[1] == components2[1]){
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(self.dateFormatter.date(from: self.selectedDate!)! >= self.dateFormatter.date(from: self.dateFormatter.string(from: Date()))!){
            if(!self.appointmentFlag[indexPath.item]){
                let components: [String] = Constants.workingTimes[indexPath.row].components(separatedBy: ":")
                let d: Date = Calendar.current.date(bySettingHour: Int(components[0])!, minute: Int(components[1])!, second: 0, of: self.datePicker.date)!
                
                let appointmentSelected: Appointment = Appointment(vetId: self.vetSelected!.id, petId: System.shared().getActiveDog()!.id, petOwnerId: System.shared().getActiveDog()!.ownerId, date: d)
                
                if #available(iOS 13.0, *) {
                    let pc: RequestAppointmentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "appointmentRequestSBId") as! RequestAppointmentViewController
                    self.delegate = pc
                    pc.delegate = self
                    self.delegate!.appointmentSelected(appointment: appointmentSelected, vetsName: vetSelected!.full_name)
                    let parent: HomepageViewController = self.parent as! HomepageViewController
                    pc.view.frame = parent.view.frame
                    parent.addChild(pc)
                    parent.view.addSubview(pc.view)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 50)
    }
    
    
    var vets: [User] = []
    var optionsData :[SwiftyMenuDisplayable] = [];
    var vetSelected: User?
    var selectedDate: String?
    let dateFormatter: DateFormatter = DateFormatter()
    var appointmentFlag: [Bool] = []
    
    var appointments: [AppoinmentModel] = []
    
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        vetSelected = vets[index]
        self.scheduleCollectionView.isHidden = false
        if(self.selectedDate != nil){
            self.setAppointmentData()
        }
        //TODO get all appointments from database for selected vet and update collectionView
    }
    

    @IBOutlet weak var vetDropdownList: SwiftyMenu!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.resetFlags()
        
        ApiService.sharedInstance.getAllVets { (vets: [User]?) in
            if(vets != nil){
                self.vets = vets!
                self.setDropdownData(dropDown: self.vetDropdownList)
            }
        }
        
        self.setDropdownParameters(dropDown: self.vetDropdownList)
        
        self.setupDatePicker()
        self.setupDateFormatter()
        
        self.scheduleCollectionView.delegate = self
        self.scheduleCollectionView.dataSource = self
        self.scheduleCollectionView.isHidden = true
    }
    
    func setupDatePicker(){
        self.datePicker.datePickerMode = .date
        
        let minDate: Date = getDate(range: -2)
        self.datePicker.minimumDate = minDate
        
        let maxDate: Date = getDate(range: 2)
        self.datePicker.maximumDate = maxDate
    }
    
    func getDate(range: Int)-> Date{
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = Calendar.current.component(.year, from: Date()) + range
        dateComponents.month = Calendar.current.component(.month, from: Date())
        dateComponents.day = Calendar.current.component(.day, from: Date())
        return Calendar.current.date(from: dateComponents)!
    }
    
    func setupDateFormatter(){
//        self.dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = DateFormatter.Style.none
    }
    
    func setDropdownData(dropDown: SwiftyMenu){
        for vet in vets{
            optionsData.append(DropdownRow(displayableValue: vet.full_name, retrivableValue: vet))
        }
        self.vetDropdownList.options = optionsData
    }
    
    func setDropdownParameters(dropDown: SwiftyMenu){
        dropDown.placeHolderText = "Chose your vet"
        dropDown.arrow = UIImage(named: "Disclosure_Arrow_1");
        dropDown.delegate = self;
        dropDown.listHeight = 100;
        dropDown.borderColor = .black
        dropDown.placeHolderColor = .blue
        dropDown.hideOptionsWhenSelect = true;
        
        dropDown.expandingAnimationStyle = .linear
        dropDown.expandingDuration = 0.5
        dropDown.collapsingAnimationStyle = .linear
        dropDown.collapsingDuration = 0.5
    }

    @IBAction func dateChanged(_ sender: Any) {
        self.selectedDate = self.dateFormatter.string(from: self.datePicker.date)
        self.setAppointmentData()
    }
    
    func setAppointmentData(){
        if(self.vetSelected != nil){
            self.appointments.removeAll()
            let d1: Date = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: self.datePicker.date)!
            
            let d2: Date = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: self.datePicker.date)!
            
            let dateRange: DateRange = DateRange(date_from: "\(d1)", date_to: "\(d2)")
            
            ApiService.sharedInstance.getAppointmentsForVetAndDate(dateRange: dateRange, vetId: self.vetSelected!.id) { (apps:[AppoinmentModel]?) in
                if(apps != nil){
                    self.appointments = apps!
                    self.resetFlags()
                    self.scheduleCollectionView.reloadData()
                } else {
                    self.resetFlags()
                    self.scheduleCollectionView.reloadData()
                }
            }
        }
    }
    
    func appointmentInserted() {
        self.setAppointmentData()
    }
    
}
