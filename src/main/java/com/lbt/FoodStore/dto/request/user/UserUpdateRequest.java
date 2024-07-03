package com.lbt.FoodStore.dto.request.user;

import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.Set;

@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Data
public class UserUpdateRequest {

    @Size(min = 6, message = "PASSWORD_INVALID")
    String password;

    String firstname;
    String lastname;
    LocalDate dob;
    Set<String> roles;
}
