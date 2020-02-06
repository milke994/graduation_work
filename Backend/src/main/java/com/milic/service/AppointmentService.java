package com.milic.service;

import com.milic.api.model.AppointmentDto;
import com.milic.db.model.AppointmentStatus;
import com.milic.db.model.Appointment;
import com.milic.db.model.Measurement;
import com.milic.db.model.Pet;
import com.milic.db.model.User;
import com.milic.db.repositories.AppointmentRepo;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppointmentService {

  private final PetService petService;
  private final UserService userService;
  private final AppointmentRepo appointmentRepo;

  @Autowired
  public AppointmentService(PetService petService, UserService userService,
                            AppointmentRepo appointmentRepo) {
    this.petService = petService;
    this.userService = userService;
    this.appointmentRepo = appointmentRepo;
  }

  public Appointment create(AppointmentDto dto) {
    Appointment appointment = new Appointment();
    Pet pet = petService.getById(dto.getPetId());
    User vet = userService.getById(dto.getVetId());
    User owner = userService.getById(dto.getPetOwnerId());
    appointment.setPet(pet);
    appointment.setPetOwner(owner);
    appointment.setVet(vet);
    appointment.setAppointmentStatus(dto.getStatus());
    appointment.setTime(dto.getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
    return appointmentRepo.save(appointment);
  }

  public List<Appointment> getByUserId(Long userId) {
    return appointmentRepo.findByVetId(userId);
  }

  public List<Appointment> getByVetAndDate(Long vetId, Date dateFrom, Date dateTo) {
    LocalDateTime from = dateFrom.toInstant().atZone(ZoneId.of("UTC+01:00")).toLocalDateTime();
    LocalDateTime to = dateTo.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
    List<Appointment> appointments = getByUserId(vetId);
    List<Appointment> collect = appointments.stream().filter(
        p -> p.getTime().isAfter(from) && p.getTime().isBefore(to)).sorted(
        Comparator.comparing(Appointment::getTime)).collect(Collectors.toList());
    return collect;
  }


  public Appointment updateStatus(Long appId, AppointmentStatus status) {
    Appointment appointment = appointmentRepo.findById(appId).orElseThrow(RuntimeException::new);
    appointment.setAppointmentStatus(status);
    appointmentRepo.save(appointment);
    return appointment;
  }
}
