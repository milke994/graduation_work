package com.milic.api.model;

public class PetInfoDto {

  private Long id;
  private Long petId;

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

  public Long getPetId() {
    return petId;
  }

  public void setPetId(Long petId) {
    this.petId = petId;
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
}
