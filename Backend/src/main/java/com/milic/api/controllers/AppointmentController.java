package com.milic.api.controllers;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

import com.milic.api.model.AppointmentDto;
import com.milic.api.model.RangeDto;
import com.milic.db.model.Appointment;
import com.milic.db.model.AppointmentStatus;
import com.milic.service.AppointmentService;
import java.util.List;
import javax.xml.ws.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/appointments")
public class AppointmentController {

  private final AppointmentService appointmentService;

  @Autowired
  public AppointmentController(AppointmentService appointmentService) {
    this.appointmentService = appointmentService;
  }

  @PostMapping(consumes = "application/json", produces = "application/json")
  Appointment createAppointment(@RequestBody AppointmentDto dto) {
    return appointmentService.create(dto);
  }

  @PostMapping("/{appId}/{appointmentStatus}")
  Appointment updateStatus(@PathVariable("appId") long appId,
                           @PathVariable("appointmentStatus") AppointmentStatus status) {
    return appointmentService.updateStatus(appId, status);
  }

  @PostMapping("/{vetId}/")
  List<Appointment> findByIdAndPath(@PathVariable("vetId") long vetId,
                                    @RequestBody RangeDto dto) {
    return appointmentService.getByVetAndDate(vetId, dto.getDateFrom(), dto.getDateTo());
  }

  @RequestMapping("/{vetId}/")
  List<Appointment> getByTypeAndVetId(@PathVariable("vetId") long vetId) {
    return appointmentService.getByUserId(vetId);
  }



}
