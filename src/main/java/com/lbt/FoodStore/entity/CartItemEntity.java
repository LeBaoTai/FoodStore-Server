package com.lbt.FoodStore.entity;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Set;

@Entity
@Table(name = "cart_items")
@Data
@Builder
@FieldDefaults(level= AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
public class CartItemEntity {
    @Id
    String id;

    @ManyToMany
    Set<ProductEntity> products;
}
