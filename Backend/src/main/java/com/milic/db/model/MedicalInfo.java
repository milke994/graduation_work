package com.milic.db.model;

import com.milic.api.model.MedicalInfoDto;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "medical_info")
public class MedicalInfo {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String allergies;
  private String diseases;
  private String treatments;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getAllergies() {
    return allergies;
  }

  public void setAllergies(String allergies) {
    this.allergies = allergies;
  }

  public String getDiseases() {
    return diseases;
  }

  public void setDiseases(String diseases) {
    this.diseases = diseases;
  }

  public String getTreatments() {
    return treatments;
  }

  public void setTreatments(String treatments) {
    this.treatments = treatments;
  }

  public static MedicalInfo fromDto(MedicalInfoDto dto) {
    MedicalInfo medicalInfo = new MedicalInfo();
    medicalInfo.setAllergies(dto.getAllergies());
    medicalInfo.setDiseases(dto.getDiseases());
    medicalInfo.setTreatments(dto.getTreatments());
    return medicalInfo;
  }
}
