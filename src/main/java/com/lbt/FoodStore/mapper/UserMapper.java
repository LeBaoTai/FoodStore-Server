package com.lbt.FoodStore.mapper;

import com.lbt.FoodStore.dto.request.user.UserCreationRequest;
import com.lbt.FoodStore.dto.request.user.UserUpdateRequest;
import com.lbt.FoodStore.dto.response.user.UserResponse;
import com.lbt.FoodStore.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "roles", ignore = true)
    void update(@MappingTarget UserEntity entity, UserUpdateRequest request);

    @Mapping(target = "roles", ignore = true)
    UserEntity toEntity(UserCreationRequest request);
    UserResponse toResponse(UserEntity userEntity);
}
