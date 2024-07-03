package com.lbt.FoodStore.service;

import com.lbt.FoodStore.dto.request.author.PermissionRequest;
import com.lbt.FoodStore.dto.response.author.PermissionResponse;
import com.lbt.FoodStore.entity.PermissionEntity;
import com.lbt.FoodStore.enums.ErrorCode;
import com.lbt.FoodStore.excep.AppException;
import com.lbt.FoodStore.mapper.PermissionMapper;
import com.lbt.FoodStore.repository.PermissionRepository;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionService {

    @Autowired
    PermissionRepository repository;

    @Autowired
    PermissionMapper mapper;

    public PermissionResponse create(PermissionRequest request) {
        if(repository.existsByName(request.getName())) {
            throw new AppException(ErrorCode.PERMISSION_ALREADY_EXISTED);
        }

        PermissionEntity permission = mapper.toEntity(request);
        return mapper.toResponse(repository.save(permission));
    }

    public List<PermissionResponse> getAllPermissions() {
        return repository.findAll().stream().map(mapper::toResponse).toList();
    }

    public void delete(String name) {
        repository.deleteById(name);
    }
}
