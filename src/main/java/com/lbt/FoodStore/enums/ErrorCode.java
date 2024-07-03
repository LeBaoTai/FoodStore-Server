package com.lbt.FoodStore.enums;

import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public enum ErrorCode {
    UNKNOWN_ERROR(9999, "Unknown error", HttpStatus.BAD_REQUEST),

    UNAUTHENTICATED(8000, "Unauthenticated!", HttpStatus.UNAUTHORIZED),
    UNAUTHORIZED(8001, "Youn don't have permission", HttpStatus.FORBIDDEN),

    USER_NOT_FOUND(1001, "User not found!", HttpStatus.NOT_FOUND),
    USERNAME_ALREADY_EXISTED(1002, "Username already existed!", HttpStatus.CONFLICT),

    PASSWORD_INVALID(1003, "Password at least 6 characters!", HttpStatus.BAD_REQUEST),
    USERNAME_INVALID(1004, "Username at least 6 characters!", HttpStatus.BAD_REQUEST),

    PRODUCT_NOT_FOUND(2001, "Product not found!", HttpStatus.NOT_FOUND),
    PRODUCT_ALREADY_EXISTED(2002, "Product already existed!", HttpStatus.CONFLICT),

    PERMISSION_ALREADY_EXISTED(3001, "Permission already existed", HttpStatus.CONFLICT),
    ROLE_ALREADY_EXISTED(4001, "Role already existed", HttpStatus.CONFLICT),
    ;

    int code;
    String message;
    HttpStatusCode httpStatusCode;
}
