package com.milic.db.repositories;

import com.milic.db.model.Pet;
import com.milic.db.model.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PetRepo extends JpaRepository<Pet, Long> {

  List<Pet> findByOwner(User owner);
}
