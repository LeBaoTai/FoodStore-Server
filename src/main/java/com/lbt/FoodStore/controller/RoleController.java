package com.lbt.FoodStore.controller;

import com.lbt.FoodStore.dto.request.author.RoleRequest;
import com.lbt.FoodStore.dto.response.ApiResponse;
import com.lbt.FoodStore.dto.response.author.RoleResponse;
import com.lbt.FoodStore.service.RoleService;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/roles")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Builder
public class RoleController {
    @Autowired
    RoleService service;

    @PostMapping
    ApiResponse<RoleResponse> create(@RequestBody RoleRequest request) {
        return ApiResponse.<RoleResponse>builder()
                .result(service.create(request))
                .build();
    }

    @GetMapping
    ApiResponse<List<RoleResponse>> getAllPermission() {
        return ApiResponse.<List<RoleResponse>>builder()
                .result(service.getAllRoles())
                .build();
    }

    @DeleteMapping("/{name}")
    ApiResponse<String> delete(@PathVariable String name) {
        service.delete(name);
        return ApiResponse.<String>builder()
                .result("Permission deleted")
                .build();
    }
}
