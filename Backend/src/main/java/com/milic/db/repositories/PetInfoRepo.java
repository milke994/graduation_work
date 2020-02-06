package com.milic.db.repositories;

import com.milic.db.model.PetInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PetInfoRepo extends JpaRepository<PetInfo, Long> {
}
