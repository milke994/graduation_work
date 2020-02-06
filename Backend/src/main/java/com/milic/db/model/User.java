package com.milic.db.model;

import com.milic.api.model.UserDto;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "users")
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "full_name")
  private String fullName;
  private String email;
  private String password;
  private String phoneNumber;
  private int firstLogin;

  @Column(name = "user_type")
  @Enumerated(EnumType.STRING)
  private UserType userType;

  public User() {}

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getFullName() {
    return fullName;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
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

  public static User fromDto(UserDto dto) {
    User user = new User();
    user.setEmail(dto.getEmail());
    user.setFullName(dto.getFullName());
    user.setPassword(dto.getPassword());
    user.setUserType(dto.getUserType());
    user.setPhoneNumber(dto.getPhoneNumber());
    user.setFirstLogin(dto.getFirstLogin());
    return user;
  }
}
