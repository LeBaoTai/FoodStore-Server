package com.lbt.FoodStore.repository;

import com.lbt.FoodStore.entity.PermissionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PermissionRepository extends JpaRepository<PermissionEntity, String> {
    boolean existsByName(String name);
}
