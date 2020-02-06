package com.milic.db.repositories;

import com.milic.db.model.Measurement;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MeasurementRepo extends JpaRepository<Measurement, Long> {
  List<Measurement> findByPetId(Long petId);
}
