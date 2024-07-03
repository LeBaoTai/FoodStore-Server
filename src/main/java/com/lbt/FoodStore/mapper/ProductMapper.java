package com.lbt.FoodStore.mapper;

import com.lbt.FoodStore.dto.request.product.ProductCreationRequest;
import com.lbt.FoodStore.dto.request.product.ProductUpdateRequest;
import com.lbt.FoodStore.dto.response.product.ProductResponse;
import com.lbt.FoodStore.entity.ProductEntity;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    void update(@MappingTarget ProductEntity entity, ProductUpdateRequest request);
    ProductEntity toEntity(ProductCreationRequest request);
    ProductResponse toResponse(ProductEntity entity);
}
