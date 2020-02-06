//
//  CalendarViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol vetAppointmentScheduleProtocol {
    func selected(date: Date)
}

protocol VetAppointmentSelectedProtocol {
    func appointmentSelected(appointment: AppoinmentModel)
}

class VetCalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AppointmentInsertedProtocol {
    
    

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var appointmentsTableView: UITableView!
    var delegate: vetAppointmentScheduleProtocol?
    var delegate2: VetAppointmentSelectedProtocol?
    var selectedDate: Date?
    var appointments: [AppoinmentModel] = []
    var appointmentFlag: [Bool] = []
    var appointmentSelected: AppoinmentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.appointmentsTableView.delegate = self
        self.appointmentsTableView.dataSource = self
        
        self.initData()
        // Do any additional setup after loading the view.
    }
    
    func resetFlags(){
        self.appointmentFlag.removeAll()
        for _ in Constants.workingTimes{
            self.appointmentFlag.append(false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        VetConstants.workingTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let timeLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let ownerName: UILabel = cell.viewWithTag(2) as! UILabel
        let petName: UILabel = cell.viewWithTag(3) as! UILabel
        
        ownerName.isHidden = true
        petName.isHidden = true
        
        cell.backgroundColor = .white
        
        if(appointments.count > 0){
            for appointment in appointments {
                if(checkIfEqual(date1: Constants.workingTimes[indexPath.item], date2: appointment.time)){
                    self.appointmentFlag[indexPath.item] = true
                    cell.backgroundColor = .red
                    
                    ownerName.isHidden = false
                    petName.isHidden = false
                    
                    ownerName.text = appointment.pet_owner.full_name
                    petName.text = appointment.pet.name
                }
            }
        }
        
        timeLabel.text = VetConstants.workingTimes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let components: [String] = VetConstants.workingTimes[indexPath.row].components(separatedBy: ":")
        self.selectedDate = Calendar.current.date(bySettingHour: Int(components[0])!, minute: Int(components[1])!, second: 0, of: self.datePicker.date)!
        print(self.selectedDate!)
        
        if(!self.appointmentFlag[indexPath.item]){
            performSegue(withIdentifier: "ScheduleSegue", sender: self)
        } else {
            for appointment in self.appointments{
                if(checkIfEqual(date1: Constants.workingTimes[indexPath.row], date2: appointment.time)){
                    self.appointmentSelected = appointment
                }
            }
            performSegue(withIdentifier: "addMedicalFileSegue", sender: self)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ScheduleSegue"){
            let vc: VetScheduleViewController = segue.destination as! VetScheduleViewController
            self.delegate = vc
            vc.delegate = self
            self.delegate?.selected(date: self.selectedDate!)
            
        } else {
            let vc: VetAddMedicalFileViewController = segue.destination as! VetAddMedicalFileViewController
            self.delegate2 = vc
            self.delegate2?.appointmentSelected(appointment:self.appointmentSelected!)
        }
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        self.setAppointmentData()
    }
    
    func initData(){
        self.appointments.removeAll()
            let d1: Date = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date())!
            
            let d2: Date = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
            
            let dateRange: DateRange = DateRange(date_from: "\(d1)", date_to: "\(d2)")
            
        ApiService.sharedInstance.getAppointmentsForVetAndDate(dateRange: dateRange, vetId: System.shared().getLogedInUser()!.id) { (apps:[AppoinmentModel]?) in
            if(apps != nil){
                self.appointments = apps!
                self.resetFlags()
                self.appointmentsTableView.reloadData()
            } else {
                self.resetFlags()
                self.appointmentsTableView.reloadData()
            }
        }
    }
    
    func setAppointmentData(){
            self.appointments.removeAll()
            let d1: Date = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: self.datePicker.date)!
            
            let d2: Date = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: self.datePicker.date)!
            
            let dateRange: DateRange = DateRange(date_from: "\(d1)", date_to: "\(d2)")
            
        ApiService.sharedInstance.getAppointmentsForVetAndDate(dateRange: dateRange, vetId: System.shared().getLogedInUser()!.id) { (apps:[AppoinmentModel]?) in
            if(apps != nil){
                self.appointments = apps!
                self.resetFlags()
                self.appointmentsTableView.reloadData()
            } else {
                self.resetFlags()
                self.appointmentsTableView.reloadData()
            }
        }
    }
    
    func appointmentInserted() {
        self.setAppointmentData()
    }
    

}
