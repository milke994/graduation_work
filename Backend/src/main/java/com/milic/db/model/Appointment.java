package com.milic.db.model;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "appointments")
public class Appointment {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(optional = false)
  @JoinColumn(name = "vet_id")
  private User vet;

  @ManyToOne(optional = false)
  @JoinColumn(name = "pet_owner_id")
  private User petOwner;

  @ManyToOne(optional = false)
  @JoinColumn(name = "pet_id")
  private Pet pet;

  @Column(name = "status")
  @Enumerated(EnumType.STRING)
  private AppointmentStatus appointmentStatus;

  private LocalDateTime time;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public User getVet() {
    return vet;
  }

  public void setVet(User vet) {
    this.vet = vet;
  }

  public User getPetOwner() {
    return petOwner;
  }

  public void setPetOwner(User petOwner) {
    this.petOwner = petOwner;
  }

  public Pet getPet() {
    return pet;
  }

  public void setPet(Pet pet) {
    this.pet = pet;
  }

  public AppointmentStatus getAppointmentStatus() {
    return appointmentStatus;
  }

  public void setAppointmentStatus(AppointmentStatus appointmentStatus) {
    this.appointmentStatus = appointmentStatus;
  }

  public LocalDateTime getTime() {
    return time;
  }

  public void setTime(LocalDateTime time) {
    this.time = time;
  }
}
