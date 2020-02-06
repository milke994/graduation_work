package com.milic.api.model;

public class MedicalInfoDto {

  private Long id;
  private Long petId;

  private String allergies;
  private String diseases;
  private String treatments;

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
}
