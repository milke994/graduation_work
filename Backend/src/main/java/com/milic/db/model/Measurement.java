package com.milic.db.model;

import com.milic.api.model.MeasurementDto;
import java.time.LocalDateTime;
import java.time.ZoneId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "measurements")
public class Measurement {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private Long petId;
  private float measure;
  private LocalDateTime time;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getPetId() {
    return petId;
  }

  public void setPetId(Long petId) {
    this.petId = petId;
  }

  public float getMeasure() {
    return measure;
  }

  public void setMeasure(float measure) {
    this.measure = measure;
  }

  public LocalDateTime getTime() {
    return time;
  }

  public void setTime(LocalDateTime time) {
    this.time = time;
  }

  public static Measurement fromDto(MeasurementDto dto) {
    Measurement measurement = new Measurement();
    measurement.setMeasure(dto.getMeasure());
    measurement.setPetId(dto.getPetId());
    measurement.setTime(dto.getTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
    return measurement;
  }
}
