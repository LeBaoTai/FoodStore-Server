package com.lbt.FoodStore.controller;

import com.lbt.FoodStore.dto.request.authen.AuthenticationRequest;
import com.lbt.FoodStore.dto.request.authen.IntrospectRequest;
import com.lbt.FoodStore.dto.request.authen.LogoutRequest;
import com.lbt.FoodStore.dto.request.authen.RefreshTokenRequest;
import com.lbt.FoodStore.dto.response.ApiResponse;
import com.lbt.FoodStore.dto.response.authen.AuthenticationResponse;
import com.lbt.FoodStore.dto.response.authen.IntrospectResponse;
import com.lbt.FoodStore.service.AuthenticationService;
import com.nimbusds.jose.JOSEException;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;

@RestController
@RequestMapping("/auth")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Builder
@CrossOrigin
public class AuthenticationController {
    @Autowired
    AuthenticationService service;

    @PostMapping("/log-in")
    public ApiResponse<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request) {
        return ApiResponse.<AuthenticationResponse>builder()
                .result(service.authenticate(request))
                .build();
    }

    @PostMapping("/introspect")
    public ApiResponse<IntrospectResponse> introspect(@RequestBody IntrospectRequest request)
            throws ParseException, JOSEException {
        return ApiResponse.<IntrospectResponse>builder()
                .result(service.introspect(request))
                .build();
    }


    @PostMapping("/logout")
    public ApiResponse<Void> logout(@RequestBody LogoutRequest request)
            throws ParseException, JOSEException {
        service.logout(request);
        return ApiResponse.<Void>builder()

                .build();
    }


    @PostMapping("/refresh")
    public ApiResponse<AuthenticationResponse> refresh(@RequestBody RefreshTokenRequest request)
            throws ParseException, JOSEException {
        return ApiResponse.<AuthenticationResponse>builder()
                .result(service.refresh(request))
                .build();
    }

}
