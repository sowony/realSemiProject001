package com.between.dto;

public class TbPhotoDto {

   private String userId;
   private String originTitle;
   private String photoPath;
   
   public TbPhotoDto() {
      
   }
   
   public TbPhotoDto(String userId, String originTitle, String photoPath) {
      super();
      this.userId = userId;
      this.originTitle = originTitle;
      this.photoPath = photoPath;
   }

   public String getUserId() {
      return userId;
   }

   public void setUserId(String userId) {
      this.userId = userId;
   }

   public String getOriginTitle() {
      return originTitle;
   }

   public void setOriginTitle(String originTitle) {
      this.originTitle = originTitle;
   }

   public String getPhotoPath() {
      return photoPath;
   }

   public void setPhotoPath(String photoPath) {
      this.photoPath = photoPath;
   }

   
   @Override
   public String toString() {
      return "Dto [userId=" + userId + ", originTitle=" + originTitle + ", photoPath="
            + photoPath + "]";
   }
}