package com.between.dao;

import org.apache.ibatis.session.SqlSession;

import com.between.common.SqlMapConfig;
import com.between.dto.TbPhotoDto;

public class TbPhotoDaoImpl extends SqlMapConfig implements TbPhotoDao {

   private String namespace = "com.between.TbPhoto.mapper.";
   
   @Override
   public int tbPhotoInsert(TbPhotoDto dto) {
      SqlSession session = null;
      int res= 0;
      
      try {
         session = getSqlSessionFactory().openSession(true);
         res = session.insert(namespace+"insert", dto);   //namespace+""는 mapper의 id와 동일해야한다.
      } catch (Exception e) {
         System.out.println("tbPhotoInsert error입니다.");
         e.printStackTrace();
      } finally {
         session.close();
      }
      return res;
   }
}