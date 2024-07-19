package com.lbt.FoodStore.service;

import com.lbt.FoodStore.dto.request.user.UserCreationRequest;
import com.lbt.FoodStore.dto.request.user.UserUpdateRequest;
import com.lbt.FoodStore.dto.response.user.UserResponse;
import com.lbt.FoodStore.entity.RoleEntity;
import com.lbt.FoodStore.entity.UserEntity;
import com.lbt.FoodStore.enums.ErrorCode;
import com.lbt.FoodStore.enums.Role;
import com.lbt.FoodStore.excep.AppException;
import com.lbt.FoodStore.mapper.UserMapper;
import com.lbt.FoodStore.repository.RoleRepository;
import com.lbt.FoodStore.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class UserService {
    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    UserRepository repository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserMapper mapper;

    public UserResponse createUser(UserCreationRequest request) {
        if(repository.existsByUsername(request.getUsername()))
            throw new AppException(ErrorCode.USERNAME_ALREADY_EXISTED);
        UserEntity user = mapper.toEntity(request);
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        HashSet<String> roles = new HashSet<>();
        roles.add(Role.USER.name());
//        user.setRoles(roles);

        return mapper.toResponse(repository.save(user));
    }


    @PreAuthorize("hasRole('ADMIN')")
    public List<UserResponse> getAllUser() {
        log.info("In method get users");
        return repository.findAll().stream().map(mapper::toResponse).toList();
    }

    @PostAuthorize("returnObject.username == authentication.name")
    public UserResponse getUser(UUID id) {
        log.info("In method get one user");
        UserEntity foundUser = repository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return mapper.toResponse(foundUser);
    }

    public UserResponse getMyInfo() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String name = authentication.getName();

        UserEntity foundUser  = repository.findByUsername(name).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return mapper.toResponse(foundUser);
    }

    public UserResponse updateUser(UUID id, UserUpdateRequest request) {
        UserEntity foundUser = repository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        mapper.update(foundUser, request);
        log.info(request.getPassword());
        foundUser.setPassword(passwordEncoder.encode(request.getPassword()));

        List<RoleEntity> foundRoles = roleRepository.findAllById(request.getRoles());
        foundUser.setRoles(new HashSet<>(foundRoles));

        return mapper.toResponse(repository.save(foundUser));
    }

    public void deleteUser(UUID id) {
        repository.deleteById(id);
    }
}
