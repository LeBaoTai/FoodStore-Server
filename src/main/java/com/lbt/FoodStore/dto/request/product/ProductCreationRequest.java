package com.lbt.FoodStore.dto.request.product;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class ProductCreationRequest {

    String id;
    String name;
    BigDecimal price;
    String type;
    boolean status;

    String image;
}
