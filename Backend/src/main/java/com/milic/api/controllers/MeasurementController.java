package com.milic.api.controllers;

import com.milic.api.model.MeasurementDto;
import com.milic.api.model.PhotoDto;
import com.milic.db.model.Measurement;
import com.milic.service.MeasurementService;
import java.util.List;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/measurements")
public class MeasurementController {

  private MeasurementService service;

  public MeasurementController(MeasurementService service) {
    this.service = service;
  }

  @PostMapping()
  Measurement create(@RequestBody MeasurementDto dto) {
    return service.create(dto);
  }

  @RequestMapping("/{petId}")
  List<Measurement> getByPetId(@PathVariable("petId") long petId) {
    return service.getByPetId(petId);
  }
}
