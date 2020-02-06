package com.milic.db.repositories;

import com.milic.db.model.MedicalInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MedicalInfoRepo extends JpaRepository<MedicalInfo, Long> {
}
