package com.lbt.FoodStore.service;


import com.lbt.FoodStore.dto.request.product.ProductCreationRequest;
import com.lbt.FoodStore.dto.request.product.ProductUpdateRequest;
import com.lbt.FoodStore.dto.response.product.ProductResponse;
import com.lbt.FoodStore.entity.ProductEntity;
import com.lbt.FoodStore.enums.ErrorCode;
import com.lbt.FoodStore.excep.AppException;
import com.lbt.FoodStore.mapper.ProductMapper;
import com.lbt.FoodStore.repository.ProductRepository;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@AllArgsConstructor
public class ProductService {
    @Autowired
    ProductRepository repository;

    @Autowired
    ProductMapper mapper;

    public ProductResponse createProduct(ProductCreationRequest request) {
        if (repository.existsByName(request.getName()))
            throw new AppException(ErrorCode.PRODUCT_ALREADY_EXISTED);
        ProductEntity entity = mapper.toEntity(request);

        return mapper.toResponse(repository.save(entity));
    }

    public List<ProductResponse> getAllProducts() {
        return repository.findAll().stream().map(mapper::toResponse).toList();
    }

    public List<ProductResponse> getAllProductsByName(String name) {
        List<ProductResponse> listProducts = repository.findAllByName(name).stream().map(mapper::toResponse).toList();
        if (listProducts.isEmpty())
            throw new AppException(ErrorCode.PRODUCT_NOT_FOUND);
        return listProducts;
    }

    public List<ProductResponse> getAllProductsByType(String type) {
        List<ProductResponse> listProducts = repository.findAllByType(type).stream().map(mapper::toResponse).toList();
        if (listProducts.isEmpty())
            throw new AppException(ErrorCode.PRODUCT_NOT_FOUND);
        return listProducts;
    }

    public ProductResponse getProduct(String id) {
        ProductEntity foundProduct = repository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_FOUND));

        return mapper.toResponse(foundProduct);
    }

    public ProductResponse updateProduct(String id, ProductUpdateRequest request) {
        ProductEntity foundProduct = repository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.PRODUCT_NOT_FOUND));

        mapper.update(foundProduct, request);

        return mapper.toResponse(repository.save(foundProduct));
    }
}
