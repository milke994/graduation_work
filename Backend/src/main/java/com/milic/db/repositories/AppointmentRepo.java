package com.milic.db.repositories;

import com.milic.db.model.AppointmentStatus;
import com.milic.db.model.Appointment;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppointmentRepo extends JpaRepository<Appointment, Long> {

  List<Appointment> findByVetId(Long vetId);
}
