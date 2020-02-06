package com.milic.db.model;

import com.milic.api.model.PetInfoDto;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "pet_info")
public class PetInfo {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String indoor;
  private String foodType;
  private String mealSize;
  private int mealsPerDay;
  private String physicalActivity;
  private String traveling;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getIndoor() {
    return indoor;
  }

  public void setIndoor(String indoor) {
    this.indoor = indoor;
  }

  public String getFoodType() {
    return foodType;
  }

  public void setFoodType(String foodType) {
    this.foodType = foodType;
  }

  public String getMealSize() {
    return mealSize;
  }

  public void setMealSize(String mealSize) {
    this.mealSize = mealSize;
  }

  public int getMealsPerDay() {
    return mealsPerDay;
  }

  public void setMealsPerDay(int mealsPerDay) {
    this.mealsPerDay = mealsPerDay;
  }

  public String getPhysicalActivity() {
    return physicalActivity;
  }

  public void setPhysicalActivity(String physicalActivity) {
    this.physicalActivity = physicalActivity;
  }

  public String getTraveling() {
    return traveling;
  }

  public void setTraveling(String traveling) {
    this.traveling = traveling;
  }

  public static PetInfo fromDto(PetInfoDto dto) {
    PetInfo petInfo = new PetInfo();
    petInfo.setFoodType(dto.getFoodType());
    petInfo.setIndoor(dto.getIndoor());
    petInfo.setMealSize(dto.getMealSize());
    petInfo.setTraveling(dto.getTraveling());
    petInfo.setPhysicalActivity(dto.getPhysicalActivity());
    petInfo.setMealsPerDay(dto.getMealsPerDay());
    return petInfo;
  }
}
