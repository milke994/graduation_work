package com.milic.db.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.milic.api.model.PetDto;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "pets")
public class Pet {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne
  @JoinColumn(name = "owner")
  private User owner;

  @OneToOne
  @JoinColumn(name = "pet_info_id")
  private PetInfo petInfo;

  @OneToOne
  @JoinColumn(name = "medical_info_id")
  private MedicalInfo medicalInfo;

  private Long petProfilePicture;

  private String name;
  private String breed;
  private int age;
  private float weight;

  @Enumerated(EnumType.STRING)
  private Species species;

  public Long getPetProfilePicture() {
    return petProfilePicture;
  }

  public void setPetProfilePicture(Long petProfilePicture) {
    this.petProfilePicture = petProfilePicture;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public User getOwner() {
    return owner;
  }

  public void setOwner(User owner) {
    this.owner = owner;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getBreed() {
    return breed;
  }

  public void setBreed(String breed) {
    this.breed = breed;
  }

  public int getAge() {
    return age;
  }

  public void setAge(int age) {
    this.age = age;
  }

  public float getWeight() {
    return weight;
  }

  public void setWeight(float weight) {
    this.weight = weight;
  }

  public Species getSpecies() {
    return species;
  }

  public void setSpecies(Species species) {
    this.species = species;
  }

  public PetInfo getPetInfo() {
    return petInfo;
  }

  public void setPetInfo(PetInfo petInfo) {
    this.petInfo = petInfo;
  }

  public MedicalInfo getMedicalInfo() {
    return medicalInfo;
  }

  public void setMedicalInfo(MedicalInfo medicalInfo) {
    this.medicalInfo = medicalInfo;
  }

  public static Pet fromDto(PetDto petDto) {
    Pet pet = new Pet();
    pet.setAge(petDto.getAge());
    pet.setBreed(petDto.getBreed());
    pet.setName(petDto.getName());
    pet.setSpecies(petDto.getSpecies());
    pet.setWeight(petDto.getWeight());
    pet.setId(petDto.getId());
    return pet;
  }
}
