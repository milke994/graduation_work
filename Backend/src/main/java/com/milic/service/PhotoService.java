package com.milic.service;

import com.milic.api.model.PhotoDto;
import com.milic.db.model.Pet;
import com.milic.db.model.Photo;
import com.milic.db.repositories.PetRepo;
import com.milic.db.repositories.PhotoRepo;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PhotoService {

  private final PhotoRepo photoRepo;
  private final PetRepo petRepo;

  @Autowired
  public PhotoService(PhotoRepo photoRepo, PetRepo petRepo) {
    this.photoRepo = photoRepo;
    this.petRepo = petRepo;
  }

  public Photo getById(Long id) {
    return photoRepo.findById(id).orElseThrow(RuntimeException::new);
  }

  public List<Photo> getPhotosForPet(Long petId) {
    petRepo.findById(petId).orElseThrow(RuntimeException::new);
    return photoRepo.findByPetId(petId);
  }

  public Photo create(PhotoDto dto) {
    petRepo.findById((long)dto.getPetId()).orElseThrow(RuntimeException::new);
    return photoRepo.save(Photo.fromDto(dto));
  }

  public Pet setProfilePic(PhotoDto dto) {
    Photo photo = photoRepo.findById((long)dto.getId()).orElse(null);
    if (photo == null) {
      photo = create(dto);
    }
    Pet pet = petRepo.findById((long)dto.getPetId()).orElseThrow(RuntimeException::new);
    pet.setPetProfilePicture(photo.getId());
    return petRepo.save(pet);
  }

  public void deletePhoto(Long id) {
    photoRepo.deleteById(id);
  }
}
