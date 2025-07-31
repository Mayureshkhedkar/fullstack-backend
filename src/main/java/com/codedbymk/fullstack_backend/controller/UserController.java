package com.codedbymk.fullstack_backend.controller;

import com.codedbymk.fullstack_backend.exception.UserNotFoundException;
import com.codedbymk.fullstack_backend.model.User;
import com.codedbymk.fullstack_backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.nio.file.attribute.UserPrincipalNotFoundException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
@CrossOrigin("http://localhost:3000")
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/getall")
    public List<User> getallusers() {
        return userRepository.findAll();
    }

    @PostMapping("/adduser")
    User newUser(@RequestBody User newUser) {
        return userRepository.save(newUser);
    }

    @GetMapping("/getuserbyid/{id}")
    public ResponseEntity<User> getbyId(@PathVariable Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/update")
    User updateUser(@RequestBody User updatedUser, @PathVariable Long id) {
        return userRepository.findById(id)
                .map(user -> {
                    user.setName(updatedUser.getName());
                    user.setUsername(updatedUser.getUsername());
                    user.setEmail(updatedUser.getEmail());
                    return userRepository.save(user);
                })
                .orElseThrow(() -> new UserNotFoundException(id));
//    User updateUser(@PathVariable Long id, @RequestBody User updatedUser) {
//    Optional<User> old = userRepository.findById(id);
//        return userRepository.
//        if (old.isPresent()) {
//            old.setUsername(updatedUser.getUsername());
//            old.setName(updatedUser.getName());
//            old.setEmail(updatedUser.getEmail());
//            return ResponseEntity.ok(old);
//        } else {
//            return ResponseEntity.notFound().build();
//        }
//    }
    }
        @DeleteMapping("/deleteuser/{id}")
        public String deleteUser (@PathVariable Long id){
            if (!userRepository.existsById(id)) {
                throw new UserNotFoundException(id);
            }
            userRepository.deleteById(id);
            return "User with ID " + id + " has been deleted.";
        }
    }


