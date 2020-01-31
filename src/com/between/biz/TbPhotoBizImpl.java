package com.between.biz;

import com.between.dao.TbPhotoDaoImpl;
import com.between.dto.TbPhotoDto;

public class TbPhotoBizImpl implements TbPhotoBiz {

   private TbPhotoDaoImpl dao = new TbPhotoDaoImpl();


   @Override
   public int tbPhotoInsert(TbPhotoDto dto) {
      return dao.tbPhotoInsert(dto);
   }
   
}