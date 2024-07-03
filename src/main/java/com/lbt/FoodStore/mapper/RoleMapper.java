package com.lbt.FoodStore.mapper;

import com.lbt.FoodStore.dto.request.author.RoleRequest;
import com.lbt.FoodStore.dto.response.author.RoleResponse;
import com.lbt.FoodStore.entity.RoleEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface RoleMapper {

    @Mapping(target = "permissions", ignore = true)
    RoleEntity toEntity(RoleRequest request);

    RoleResponse toResponse(RoleEntity entity);
}
