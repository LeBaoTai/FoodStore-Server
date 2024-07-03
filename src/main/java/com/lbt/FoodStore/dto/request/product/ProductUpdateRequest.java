package com.lbt.FoodStore.dto.request.product;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Data
public class ProductUpdateRequest {

    String name;
    BigDecimal price;
    String type;
    boolean status;
    String image;
}
