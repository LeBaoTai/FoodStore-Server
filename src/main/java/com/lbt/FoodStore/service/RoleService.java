package com.lbt.FoodStore.service;


import com.lbt.FoodStore.dto.request.author.RoleRequest;
import com.lbt.FoodStore.dto.response.author.RoleResponse;
import com.lbt.FoodStore.entity.PermissionEntity;
import com.lbt.FoodStore.entity.RoleEntity;
import com.lbt.FoodStore.mapper.RoleMapper;
import com.lbt.FoodStore.repository.PermissionRepository;
import com.lbt.FoodStore.repository.RoleRepository;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@AllArgsConstructor
public class RoleService {
    @Autowired
    RoleRepository repository;

    @Autowired
    PermissionRepository permissionRepository;

    @Autowired
    RoleMapper mapper;

    public RoleResponse create(RoleRequest request) {
        RoleEntity role = mapper.toEntity(request);

        List<PermissionEntity> permissions = permissionRepository.findAllById(request.getPermissions());
        role.setPermissions(new HashSet<>(permissions));

        return mapper.toResponse(repository.save(role));
    }

    public List<RoleResponse> getAllRoles() {
        return repository.findAll().stream().map(mapper::toResponse).toList();
    }

    public void delete(String name) {
        repository.deleteById(name);
    }
}
