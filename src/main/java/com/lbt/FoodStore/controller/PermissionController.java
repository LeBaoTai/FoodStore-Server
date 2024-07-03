package com.lbt.FoodStore.controller;

import com.lbt.FoodStore.dto.request.author.PermissionRequest;
import com.lbt.FoodStore.dto.response.ApiResponse;
import com.lbt.FoodStore.dto.response.author.PermissionResponse;
import com.lbt.FoodStore.service.PermissionService;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/permissions")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Builder
public class PermissionController {
    @Autowired
    PermissionService service;

    @PostMapping
    ApiResponse<PermissionResponse> create(@RequestBody PermissionRequest request) {
        return ApiResponse.<PermissionResponse>builder()
                .result(service.create(request))
                .build();
    }

    @GetMapping
    ApiResponse<List<PermissionResponse>> getAllPermission() {
        return ApiResponse.<List<PermissionResponse>>builder()
                .result(service.getAllPermissions())
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
