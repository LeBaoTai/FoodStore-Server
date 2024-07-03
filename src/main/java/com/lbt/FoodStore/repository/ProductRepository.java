package com.lbt.FoodStore.repository;

import com.lbt.FoodStore.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<ProductEntity, String> {
    List<ProductEntity> findAllByName(String name);
    List<ProductEntity> findAllByType(String type);
    boolean existsByName(String name);
}
