package com.milic.service;

import com.milic.api.model.UserDto;
import com.milic.db.model.User;
import com.milic.db.model.UserType;
import com.milic.db.repositories.UserRepo;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

@Service
public class UserService {

  private final UserRepo userRepo;

  @Autowired
  public UserService(UserRepo userRepo) {
    this.userRepo = userRepo;
  }

  public User create(UserDto userDto) {
    return userRepo.save(User.fromDto(userDto));
  }

  public List<User> getByType(UserType userType) {
    return userRepo.findByUserType(userType);
  }

  public User getByEmail(String email) {
    Optional<User> maybeUser = userRepo.findByEmail(email);
    return maybeUser.orElse(null);
  }

  public User getById(Long id) {
    return userRepo.findById(id).orElse(null);
  }

  public void changeUserLogedIn(Long userId){
    User user = userRepo.findById(userId).orElse(null);
    if(user != null){
      user.setFirstLogin(0);
      userRepo.save(user);
    }
  }
}
