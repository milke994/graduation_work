package com.milic.service;

import com.milic.api.model.MeasurementDto;
import com.milic.db.model.Measurement;
import com.milic.db.repositories.MeasurementRepo;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MeasurementService {

  public final MeasurementRepo repo;

  @Autowired
  public MeasurementService(MeasurementRepo repo) {
    this.repo = repo;
  }

  public Measurement create(MeasurementDto dto) {
    return repo.save(Measurement.fromDto(dto));
  }

  public List<Measurement> getByPetId(Long petId) {
    List<Measurement> list = repo.findByPetId(petId);
    list.sort(Comparator.comparing(Measurement::getTime));
    return list;
  }
}
