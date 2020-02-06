package com.milic.api.model;

import com.milic.db.model.UserType;

public class UserDto {

  private String fullName;
  private String password;
  private String email;
  private UserType userType;
  private String phoneNumber;
  private int firstLogin;

  public String getFullName() {
    return fullName;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public UserType getUserType() {
    return userType;
  }

  public void setUserType(UserType userType) {
    this.userType = userType;
  }

  public String getPhoneNumber() {
    return phoneNumber;
  }

  public void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  public int getFirstLogin() {
    return firstLogin;
  }

  public void setFirstLogin(int firstLogin) {
    this.firstLogin = firstLogin;
  }
}
