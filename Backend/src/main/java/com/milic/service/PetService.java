package com.milic.service;

import com.milic.api.model.MedicalInfoDto;
import com.milic.api.model.PetDto;
import com.milic.api.model.PetInfoDto;
import com.milic.db.model.MedicalInfo;
import com.milic.db.model.Pet;
import com.milic.db.model.PetInfo;
import com.milic.db.model.User;
import com.milic.db.repositories.MedicalInfoRepo;
import com.milic.db.repositories.PetInfoRepo;
import com.milic.db.repositories.PetRepo;
import com.milic.db.repositories.UserRepo;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PetService {

  private final PetRepo petRepo;
  private final UserRepo userRepo;
  private final PetInfoRepo petInfoRepo;
  private final MedicalInfoRepo medicalInfoRepo;

  @Autowired
  public PetService(PetRepo petRepo, UserRepo userRepo, PetInfoRepo petInfoRepo,
                    MedicalInfoRepo medicalInfoRepo) {
    this.petRepo = petRepo;
    this.userRepo = userRepo;
    this.petInfoRepo = petInfoRepo;
    this.medicalInfoRepo = medicalInfoRepo;
  }

  public Pet create(PetDto petDto) {
    Optional<User> owner = userRepo.findById(petDto.getOwnerId());
    if (!owner.isPresent()) {
      throw new RuntimeException("No user with id " + petDto.getOwnerId());
    }

    Pet pet = Pet.fromDto(petDto);
    pet.setOwner(owner.get());
    return petRepo.save(pet);
  }

  public Pet getById(Long id) {
    return petRepo.findById(id).orElse(null);
  }

  public List<Pet> findByOwner(Long ownerId) {
    Optional<User> owner = userRepo.findById(ownerId);
    return owner.map(petRepo::findByOwner).orElse(null);
  }

  public Pet createPetInfo(PetInfoDto petInfoDto) {
    Pet pet = petRepo.findById(petInfoDto.getPetId()).orElseThrow(RuntimeException::new);
    PetInfo petInfo = PetInfo.fromDto(petInfoDto);
    petInfoRepo.save(petInfo);
    pet.setPetInfo(petInfo);
    petRepo.save(pet);
    return pet;
  }

  public Pet createMedicalInfo(MedicalInfoDto dto) {
    Pet pet = petRepo.findById(dto.getPetId()).orElseThrow(RuntimeException::new);
    MedicalInfo medicalInfo = MedicalInfo.fromDto(dto);
    medicalInfoRepo.save(medicalInfo);
    pet.setMedicalInfo(medicalInfo);
    petRepo.save(pet);
    return pet;
  }
}
