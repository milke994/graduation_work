package com.milic.db.repositories;

import com.milic.db.model.Photo;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PhotoRepo extends JpaRepository<Photo, Long> {
  List<Photo> findByPetId(Long petId);
}
