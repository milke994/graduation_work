package com.milic.api.controllers;

import com.milic.api.model.PhotoDto;
import com.milic.db.model.Pet;
import com.milic.db.model.Photo;
import com.milic.service.PetService;
import com.milic.service.PhotoService;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/v1/photos", consumes = "application/json", produces = "application/json")
public class PhotoController {

  private final PhotoService photoService;

  @Autowired
  public PhotoController(PhotoService photoService) {
    this.photoService = photoService;
  }

  @PostMapping()
  PhotoDto create(@RequestBody PhotoDto dto) {
    return photoService.create(dto).toDto();
  }

  @PostMapping("/profile")
  Pet createProfile(@RequestBody PhotoDto dto) {
    return photoService.setProfilePic(dto);
  }

  @RequestMapping("/{id}")
  PhotoDto getById(@PathVariable("id") long photoId) {
    return photoService.getById(photoId).toDto();
  }

  @RequestMapping("/pets/{id}")
  List<PhotoDto> getPhotosById(@PathVariable("id") long petId) {
    return photoService.getPhotosForPet(petId).stream().map(Photo::toDto).collect(
        Collectors.toList());
  }
}
