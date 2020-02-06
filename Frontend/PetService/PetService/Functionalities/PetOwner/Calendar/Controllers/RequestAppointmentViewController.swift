//
//  RequestAppointmentViewController.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class RequestAppointmentViewController: UIViewController, AppointmentSelectedProtocol {
    func appointmentSelected(appointment: Appointment, vetsName: String) {
        self.appointmentSelected = appointment
        self.vetsName = vetsName
    }
    
    func appointmentSelected(appointment: Appointment) {
        self.appointmentSelected = appointment
    }
    

    @IBOutlet weak var veterianNameLabel: UILabel!
    @IBOutlet weak var petsNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var appointmentSelected: Appointment?
    var vetsName: String?
    var delegate: AppointmentInsertedProtocol?
    
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.veterianNameLabel.text = self.vetsName!
        self.petsNameLabel.text = System.shared().getActiveDog()!.name
        self.setupDateFormatter()
        self.dateLabel.text = self.dateFormatter.string(from: appointmentSelected!.date)
        // Do any additional setup after loading the view.
    }
    
    func setupDateFormatter(){
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .medium
    }

    @IBAction func requestButtonClicked(_ sender: Any) {
        print(self.appointmentSelected!.date)
        let appointment: NewAppointment = NewAppointment(vet_id: self.appointmentSelected!.vetId, pet_owner_id: self.appointmentSelected!.petOwnerId, pet_id: self.appointmentSelected!.petId, date: "\(self.appointmentSelected!.date)")
        
        ApiService.sharedInstance.createAppoinment(appointment: appointment, completion: {
            self.delegate?.appointmentInserted()
        })
        self.delegate?.appointmentInserted()
        self.removeFromParent()
        self.view.removeFromSuperview()
        //save appointment to database
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
}
