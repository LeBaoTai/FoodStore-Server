package com.lbt.FoodStore.mapper;

import com.lbt.FoodStore.dto.request.author.PermissionRequest;
import com.lbt.FoodStore.dto.response.author.PermissionResponse;
import com.lbt.FoodStore.entity.PermissionEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface PermissionMapper {
    PermissionEntity toEntity(PermissionRequest request);
    PermissionResponse toResponse(PermissionEntity entity);
}
