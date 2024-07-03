package com.lbt.FoodStore.controller;


import com.lbt.FoodStore.dto.request.product.ProductCreationRequest;
import com.lbt.FoodStore.dto.request.product.ProductUpdateRequest;
import com.lbt.FoodStore.dto.response.ApiResponse;
import com.lbt.FoodStore.dto.response.product.ProductResponse;
import com.lbt.FoodStore.service.ProductService;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/products")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Builder
public class ProductController {
    @Autowired
    ProductService service;

    @PostMapping
    public ApiResponse<ProductResponse> createProduct(@RequestBody ProductCreationRequest request) {
        log.info(request.toString());
        return ApiResponse.<ProductResponse>builder()
                .result(service.createProduct(request))
                .build();
    }

    @GetMapping("/all")
    public ApiResponse<List<ProductResponse>> getAllProducts() {
        return ApiResponse.<List<ProductResponse>>builder()
                .result(service.getAllProducts())
                .build();
    }

    @GetMapping("/all/name/{name}")
    public ApiResponse<List<ProductResponse>> getAllProductsByName(@PathVariable String name) {
        return ApiResponse.<List<ProductResponse>>builder()
                .result(service.getAllProductsByName(name))
                .build();
    }

    @GetMapping("/all/type/{type}")
    public ApiResponse<List<ProductResponse>> getAllProductsByType(@PathVariable String type) {
        return ApiResponse.<List<ProductResponse>>builder()
                .result(service.getAllProductsByType(type))
                .build();
    }


    @GetMapping("/{id}")
    public ApiResponse<ProductResponse> getProductById(@PathVariable String id) {
        return ApiResponse.<ProductResponse>builder()
                .result(service.getProduct(id))
                .build();
    }

    @PutMapping("/{id}")
    public ApiResponse<ProductResponse> updateProduct(@PathVariable String id, @RequestBody ProductUpdateRequest request) {
        return ApiResponse.<ProductResponse>builder()
                .result(service.updateProduct(id, request))
                .build();
    }

}
