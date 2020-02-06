package com.milic.db.model;

import com.milic.api.model.PhotoDto;
import java.util.Arrays;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "photos")
public class Photo {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private Long petId;

  private byte[] photo;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public byte[] getPhoto() {
    return photo;
  }

  public void setPhoto(byte[] photo) {
    this.photo = photo;
  }

  public Long getPetId() {
    return petId;
  }

  public void setPetId(Long petId) {
    this.petId = petId;
  }

  public static Photo fromDto(PhotoDto dto) {
    Photo photo = new Photo();
    photo.setId((long)dto.getId());
    photo.setPetId((long)dto.getPetId());
    photo.setPhoto(dto.getPhoto().getBytes());
    return photo;
  }

  public PhotoDto toDto() {
    PhotoDto photoDto = new PhotoDto();
    photoDto.setId(id.intValue());
    photoDto.setPetId(petId.intValue());
    photoDto.setPhoto(new String(photo));
    return photoDto;
  }
}
